import XCTest
@testable import TheCatsAPI

class URLBuilderTests: XCTestCase {
    typealias TestResponse = [Int]
    var sut: URLBuilder!
    var request: RequestProtocolMock<TestResponse>!
    var parameters: ParametersMappingProtocolMock!

    override func setUpWithError() throws {
        sut = URLBuilder()
        request = RequestProtocolMock()
        parameters = ParametersMappingProtocolMock()
        request.parameters = parameters
    }

    func test_urlRequest_invalidBase_failsToCreateRequest() throws {
        request.path = "path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "somethingStrange")

        XCTAssertNil(urlRequest)
    }

    func test_urlRequest_emptyBase_failsToCreateRequest() throws {
        request.path = "path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "")

        XCTAssertNil(urlRequest)
    }

    func test_urlRequest_invalidPath_failsToCreateRequest() throws {
        request.path = "something like not a path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertNil(urlRequest)
    }

    func test_urlRequest_emptyPath_failsToCreateRequest() throws {
        request.path = ""
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertNil(urlRequest)
    }

    func test_urlRequest_validPathMethodBase_passHTTPMethod() throws {
        request.path = "path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.httpMethod, "GET")
    }

    func test_urlRequest_validPathMethodBase_passPath() throws {
        request.path = "path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path")
    }

    func test_urlRequest_invalidPath_passValiPath() throws {
        request.path = "/path/"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path")
    }

    func test_urlRequest_invalidPathBase_passValiPath() throws {
        request.path = "/path/"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com/")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path")
    }

    func test_urlRequest_validPathMethodBase_passBaseSuffix() throws {
        request.path = "path"
        request.httpMethod = "GET"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com/brand/new/vesrion/1")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/brand/new/vesrion/1/path")
    }

    func test_urlRequest_validPathMethodBaseQuery_passQuery() throws {
        request.path = "path"
        request.httpMethod = "GET"
        parameters.queryItems = [
            URLQueryItem(name: "key1", value: "value1"),
            URLQueryItem(name: "key2", value: "value2"),
            URLQueryItem(name: "array", value: "v1"),
            URLQueryItem(name: "array", value: "v2"),
            URLQueryItem(name: "array", value: "v3")
        ]

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path?key1=value1&key2=value2&array=v1&array=v2&array=v3")
    }

    func test_urlRequest_validPathMethodBaseEmptyQuery_doesntPassQuery() throws {
        request.path = "path"
        request.httpMethod = "GET"
        parameters.queryItems = []

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path")
    }

    func test_urlRequest_getMethod_doesntPassBody() throws {
        request.path = "path"
        request.httpMethod = "GET"
        parameters.body = "{key:value}".data(using: .utf8)

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertNil(urlRequest?.httpBody)
    }

    func test_urlRequest_postMethod_passHTTPMethod() throws {
        request.path = "path"
        request.httpMethod = "POST"

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.httpMethod, "POST")
    }

    func test_urlRequest_postMethodBody_passHTTPMethod() throws {
        request.path = "path"
        request.httpMethod = "POST"
        parameters.body = "{key:value}".data(using: .utf8)

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.httpBody, "{key:value}".data(using: .utf8))
    }

    func test_urlRequest_postMethodBody_doesntPassQuery() throws {
        request.path = "path"
        request.httpMethod = "POST"
        parameters.queryItems = [
            URLQueryItem(name: "key1", value: "value1"),
            URLQueryItem(name: "key2", value: "value2"),
            URLQueryItem(name: "array", value: "v1"),
            URLQueryItem(name: "array", value: "v2"),
            URLQueryItem(name: "array", value: "v3")
        ]

        let urlRequest = sut.urlRequest(for: request, baseURL: "http://testapi.com")

        XCTAssertEqual(urlRequest?.url?.relativeString, "http://testapi.com/path")
    }
}
