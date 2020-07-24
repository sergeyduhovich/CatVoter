import XCTest
@testable import CatVoter

class DeedPresenterTests: XCTestCase {

    var sut: FeedPresenter!
    var service: FeedServiceTypeMock!
    var view: FeedViewTypeMock!

    override func setUpWithError() throws {

        service = FeedServiceTypeMock()
        view = FeedViewTypeMock()

        sut = FeedPresenter(service: service)
        sut.view = view
    }

    func test_reloadFeed_always_callService() throws {
        sut.reloadFeed()
        XCTAssertTrue(service.fetchFeedCompeltionCalled)
    }

    func test_reloadFeed_always_showViewLoading() throws {
        sut.reloadFeed()
        XCTAssertTrue(view.showLoadingCalled)
    }
}
