//
//  DetailsViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class DetailsViewModel {
    // MARK: Properties

    private var api: APIClient
    private let login: String
    private let repository: String
    private var response: DetailsRequest.Response?

    var viewController: DetailsOutputProtocol?
    var sectionTitle: String {
        let closed = response?.filter { $0.state == .closed } ?? []
        let open = response?.filter { $0.state == .open } ?? []
        return "\(open.count) opened / \(closed.count) closed"
    }

    // MARK: Inits

    init(api: APIClient = DependencyContainer.apiClient, login: String, repository: String) {
        self.api = api
        self.login = login
        self.repository = repository
    }

    // MARK: Private Methods

    private func requestDetails() {
        api.send(DetailsRequest(login: login, repository: repository)) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.response = response
                    self?.viewController?.success(dataSource: response.toViewModel)
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }
}

// MARK: - DetailsInputProtocol

extension DetailsViewModel: DetailsInputProtocol {
    func didTapReload() {
        viewController?.startLoading()
        requestDetails()
    }

    func pullToRefresh() {
        viewController?.startLoading()
        requestDetails()
    }

    func viewDidLoad() {
        viewController?.setTitle(repository)
        viewController?.startLoading()
        requestDetails()
    }
}

private extension Array where Element == DetailsResponse {
    var toViewModel: [DetailsRowViewModel] {
        var rows: [DetailsRowViewModel] = []
        forEach { pullRequest in
            rows.append(.init(
                pullRequest: .init(
                    id: pullRequest.id,
                    name: pullRequest.title ?? "",
                    description: pullRequest.body ?? ""
                ),
                owner: .init(
                    id: pullRequest.owner.id,
                    avatarURL: pullRequest.owner.avatarURL,
                    name: pullRequest.owner.login,
                    fullName: ""
                )
            ))
        }

        return rows
    }
}
