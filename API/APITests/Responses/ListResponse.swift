import Foundation

struct ListResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}
