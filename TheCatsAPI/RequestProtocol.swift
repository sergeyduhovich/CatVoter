import Foundation

public protocol RequestProtocol {
    associatedtype Response: Decodable
    typealias Completion = (Result<Response, TheCatsError>) -> Void

    var path: String { get }
    var parameters: ParametersMappingProtocol { get set }
    var httpMethod: String { get }
}

extension RequestProtocol {
    var httpMethod: String { "GET" }
}
