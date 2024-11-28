@testable import API

class Environment: APIEnvironment {
    var domainURL: URL?
    var type: API.APIEnvironmentType

    init(domainURL: URL? = nil, type: API.APIEnvironmentType) {
        self.domainURL = domainURL
        self.type = type
    }
}

// MARK: - Utils

extension Environment {
    static var local = Environment(type: .local)
}
