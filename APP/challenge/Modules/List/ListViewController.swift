//
//  ListViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class ListViewController: WASViewController {
    // MARK: Properties

    var viewModel: ListInputProtocol
    var dataSource: [ListRowViewModel] = []

    let refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: ListInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: ListInputProtocol) -> ListViewController {
        let viewController = ListViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        title = "Github JavaPop"
        setupRefreshControl()
        setupTableView()
    }

    override func setupNavigationController() {
        super.setupNavigationController()
        navigationItem.setHidesBackButton(true, animated: true)
    }

    // MARK: Private Methods

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)

        tableView.fill(on: view)
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    private func showErrorView() {
        guard errorView == nil else { return }

        errorView = WASErrorView(delegate: self)
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }

    private func removeErrorView() {
        errorView?.alpha = 0
        errorView?.removeFromSuperview()
        errorView = nil
    }

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= dataSource.count - 1
    }

    private func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }

    // MARK: Internal Methods

    @objc func pullToRefresh() {
        viewModel.pullToRefresh()
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell
        cell?.setup(with: viewModel)

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension ListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isLoadingCell) else { return }
        viewModel.prefetchRows()
    }
}

// MARK: - WASErrorViewDelegate

extension ListViewController: WASErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}

// MARK: - ListOutnputProtocol

extension ListViewController: ListOutputProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0
            self?.removeErrorView()
        }
    }

    func requestSuccess(dataSource: [ListRowViewModel]) {
        stopLoading()
        self.dataSource = dataSource
        tableView.reloadData()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.removeErrorView()
        }
    }

    func updateSuccess(dataSource: [ListRowViewModel]) {
        let startIndex = self.dataSource.count - dataSource.count
        let endIndex = startIndex + dataSource.count
        let indexPaths = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }

        tableView.beginUpdates()
        self.dataSource.append(contentsOf: dataSource)
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()

        // workaround for insertRow to work correctly
        if let lastIndexPath = indexPaths.last {
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
        }
    }

    func failure() {
        stopLoading()
        showErrorView()
    }
}
