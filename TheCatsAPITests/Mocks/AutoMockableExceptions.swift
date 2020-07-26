@testable import TheCatsAPI

class URLBuilderProtocolMock<T: RequestProtocol>: URLBuilderProtocol {
    //MARK: - urlRequest<Request: RequestProtocol>

    var urlRequestForBaseURLCallsCount = 0
    var urlRequestForBaseURLCalled: Bool {
        return urlRequestForBaseURLCallsCount > 0
    }
    var urlRequestForBaseURLReceivedArguments: (request: T, baseURL: String)?
    var urlRequestForBaseURLReceivedInvocations: [(request: T, baseURL: String)] = []
    var urlRequestForBaseURLReturnValue: URLRequest?
    var urlRequestForBaseURLClosure: ((T, String) -> URLRequest?)?

    func urlRequest<Request: RequestProtocol>(for request: Request, baseURL: String) -> URLRequest? {
        if request is T {
            urlRequestForBaseURLCallsCount += 1
            urlRequestForBaseURLReceivedArguments = (request: request, baseURL: baseURL) as? (request: T, baseURL: String)
            urlRequestForBaseURLReceivedInvocations.append((request: request, baseURL: baseURL) as! (request: T, baseURL: String))
            return urlRequestForBaseURLClosure.map({ $0(request as! T, baseURL) }) ?? urlRequestForBaseURLReturnValue
        } else {
            return nil
        }
    }
}

class RequestProtocolMock<T: Decodable>: RequestProtocol {
    typealias Response = T

    var path: String {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }
    var underlyingPath: String!
    var parameters: ParametersMappingProtocol {
        get { return underlyingParameters }
        set(value) { underlyingParameters = value }
    }
    var underlyingParameters: ParametersMappingProtocol!
    var httpMethod: String {
        get { return underlyingHttpMethod }
        set(value) { underlyingHttpMethod = value }
    }
    var underlyingHttpMethod: String!
}
