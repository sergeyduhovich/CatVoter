import Foundation

public protocol RequestProtocol {
    typealias Completion = (Result<Response, TheCatsError>) -> Void
    associatedtype Parameters: ParametersMappingProtocol
    associatedtype Response: Decodable

    var path: String { get }
    var parameters: Parameters { get set }
    var httpMethod: String { get }
}

extension RequestProtocol {
    var httpMethod: String { "GET" }
}
