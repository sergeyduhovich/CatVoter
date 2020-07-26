//
//  https://docs.thecatapi.com/api-reference/images/images-search
//

import Foundation

extension TheCatsAPI {
    public func images(parameters: ImagesRequestParameters = ImagesRequestParameters(),
                       completion: @escaping (Result<[Image], TheCatsError>) -> Void) {
        send(request: GetAllImagesRequest(parameters: parameters), completion: completion)
    }
}

struct GetAllImagesRequest: RequestProtocol {
    var path = "images/search"
    var parameters = ImagesRequestParameters()

    typealias Parameters = ImagesRequestParameters
    typealias Response = [Image]

    init(parameters: ImagesRequestParameters) {
        self.parameters = parameters
    }
}

public struct ImagesRequestParameters: Codable {
    public enum Size: String, Codable, CustomStringConvertible {
        case full
        case med
        case small
        case thumb

        public var description: String { self.rawValue }
    }

    public enum Order: String, Codable, CustomStringConvertible {
        case random = "RANDOM"
        case asc = "ASC"
        case desc = "DESC"

        public var description: String { self.rawValue }
    }

    var size: Size = .full
    var order: Order = .desc
    var limit: Int = 100
    var page: Int = 0

    public init() {}
}

extension ImagesRequestParameters: ParametersMappingProtocol {
    public var body: Data? { nil }
}
