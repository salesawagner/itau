import API

struct ListRequest: APIRequest {
    typealias Response = ListResponse

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "search/repositories"
    }

    // swiftlint:disable:next identifier_name
    var q: String {
        "language:Java"
    }

    var sort: String {
        "stars"
    }

    var page: Int

    public init(page: Int) {
        self.page = page
    }
}
