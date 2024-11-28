//
//  DetailsViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit
import API

final class DetailsViewController: WASViewController {
    // MARK: Properties

    var viewModel: DetailsInputProtocol
    var dataSource: [DetailsRowViewModel] = []

    let refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: DetailsInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: DetailsInputProtocol) -> DetailsViewController {
        let viewController = DetailsViewController(viewModel: viewModel)
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
        setupRefreshControl()
        setupTableView()
        addBackButton()
    }

    // MARK: Private Methods

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)

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

    private func removeErrorView() {
        errorView?.alpha = 0
        errorView?.removeFromSuperview()
        errorView = nil
    }

    // MARK: Internal Methods

    @objc func pullToRefresh() {
        viewModel.pullToRefresh()
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier) as? DetailsCell
        cell?.setup(with: row)

        return cell ?? UITableViewCell()
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = viewModel.sectionTitle
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .darkText
        label.textAlignment = .center

        headerView.addSubview(label)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - WASErrorViewDelegate

extension DetailsViewController: WASErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}

// MARK: - DetailsOutnputProtocol

extension DetailsViewController: DetailsOutputProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }

    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0
            self?.removeErrorView()
        }
    }

    func success(dataSource: [DetailsRowViewModel]) {
        stopLoading()
        self.dataSource = dataSource
        tableView.reloadData()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.removeErrorView()
        }
    }

    func failure() {
        stopLoading()
        guard errorView == nil else { return }

        errorView = WASErrorView(delegate: self)
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }
}
