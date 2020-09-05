import XCTest
@testable import TheCatsAPI

class TheCatsAPITests: XCTestCase {
    typealias ResponseType = [Int]
    typealias RequestType = RequestProtocolMock<ResponseType>

    var request: RequestType!
    var sut: TheCatsAPI!
    var urlBuilder: URLBuilderProtocolMock<RequestType>!

    override func setUpWithError() throws {
        request = RequestProtocolMock()
        urlBuilder = URLBuilderProtocolMock()
        sut = TheCatsAPI.init(apiKey: "QWERTY", baseURL: "http://api.com", urlBuilder: urlBuilder)
    }

    func test_sendRequest_nilRequest_failsWithInvalidURL() throws {
        urlBuilder.urlRequestForBaseURLReturnValue = nil
        var result: Result<ResponseType, TheCatsError>!

        let expectation = self.expectation(description: "test_sendRequest_nilRequest_fails")

        sut.send(request: request) { res in
            result = res
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.1, handler: nil)

        XCTAssertEqual(result, .failure(.invalidURL))
    }
}
