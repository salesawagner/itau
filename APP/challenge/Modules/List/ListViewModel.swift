//
//  ListViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class ListViewModel {
    // MARK: Properties

    private var api: APIClient

    private var incompleteResults: Bool = true
    private var page = 1
    private var isLoading: Bool = false

    private var repositories: [Repository] = []
    private var dataSource: [ListRowViewModel] = []

    var viewController: ListOutputProtocol?

    // MARK: Inits

    init(api: APIClient = DependencyContainer.apiClient) {
        self.api = api
    }

    // MARK: Private Methods

    private func requestList(page: Int = 0, increase: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        api.send(ListRequest(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.page = page
                    self?.incompleteResults = response.incompleteResults

                    if increase {
                        let viewModels = response.repositories.toViewModel
                        self?.repositories.append(contentsOf: response.repositories)
                        self?.dataSource.append(contentsOf: viewModels)
                        self?.viewController?.updateSuccess(dataSource: viewModels)
                    } else {
                        self?.dataSource = response.repositories.toViewModel
                        self?.repositories = response.repositories
                        self?.viewController?.requestSuccess(dataSource: self?.dataSource ?? [])
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.viewController?.failure()
                }
            }
        }
    }
}

// MARK: - ListInputProtocol

extension ListViewModel: ListInputProtocol {
    func didSelectRow(indexPath: IndexPath) {
        let row = dataSource[indexPath.row]
        let viewModel = DetailsViewModel(login: row.owner.name, repository: row.repository.name)
        (viewController as? UIViewController)?.navigationController?.pushViewController(
            DetailsViewController.create(with: viewModel),
            animated: true
        )
    }

    func didTapReload() {
        viewController?.startLoading()
        requestList(page: page)
    }

    func pullToRefresh() {
        viewController?.startLoading()
        requestList()
    }

    func viewDidLoad() {
        viewController?.startLoading()
        requestList()
    }

    func prefetchRows() {
        guard incompleteResults else { return }
        requestList(page: page + 1, increase: true)
    }
}

// MARK: - ListResponse Helper

private extension Array where Element == Repository {
    var toViewModel: [ListRowViewModel] {
        var rows: [ListRowViewModel] = []
        forEach { repository in
            rows.append(.init(
                repository: .init(
                    id: repository.id,
                    name: repository.name ?? "-",
                    description: repository.description ?? "-",
                    forks: repository.forksCount,
                    stars: repository.starsCount
                ),
                owner: .init(
                    id: repository.owner.id,
                    avatarURL: repository.owner.avatarURL,
                    name: repository.owner.login,
                    fullName: ""
                )
            ))
        }

        return rows
    }
}
