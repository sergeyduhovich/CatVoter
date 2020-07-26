import Foundation

public enum TheCatsError: Swift.Error {
    case invalidURL
    case decodingFailed(Error?)
    case network(Error)
    case failed(statusCode: Int)
}
