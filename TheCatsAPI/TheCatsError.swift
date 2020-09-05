import Foundation

public enum TheCatsError: Swift.Error, Equatable {
    public static func == (lhs: TheCatsError, rhs: TheCatsError) -> Bool {
        switch (lhs, rhs) {

        case (.invalidURL, .invalidURL),
             (noDataInResponse, noDataInResponse):
            return true

        case let (.decodingFailed(lhsError), .decodingFailed(rhsError)):
            return (lhsError as NSError) == (rhsError as NSError)

        case let (.network(lhsError), .network(rhsError)):
            return (lhsError as NSError) == (rhsError as NSError)

        case let (.failed(statusCode: lhsCode), .failed(statusCode: rhsCode)):
            return lhsCode == rhsCode

        default:
            return false
        }
    }

    case invalidURL
    case noDataInResponse
    case decodingFailed(Error)
    case network(Error)
    case failed(statusCode: Int)
}
