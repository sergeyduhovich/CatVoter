// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

@testable import CatVoter














class FeedPresenterTypeMock: FeedPresenterType {

    //MARK: - reloadFeed

    var reloadFeedCallsCount = 0
    var reloadFeedCalled: Bool {
        return reloadFeedCallsCount > 0
    }
    var reloadFeedClosure: (() -> Void)?

    func reloadFeed() {
        reloadFeedCallsCount += 1
        reloadFeedClosure?()
    }

    //MARK: - appendFeed

    var appendFeedCallsCount = 0
    var appendFeedCalled: Bool {
        return appendFeedCallsCount > 0
    }
    var appendFeedClosure: (() -> Void)?

    func appendFeed() {
        appendFeedCallsCount += 1
        appendFeedClosure?()
    }

}
class FeedServiceTypeMock: FeedServiceType {

    //MARK: - fetchFeed

    var fetchFeedCompeltionCallsCount = 0
    var fetchFeedCompeltionCalled: Bool {
        return fetchFeedCompeltionCallsCount > 0
    }
    var fetchFeedCompeltionReceivedCompeltion: (([Feed]) -> Void)?
    var fetchFeedCompeltionReceivedInvocations: [(([Feed]) -> Void)] = []
    var fetchFeedCompeltionClosure: ((@escaping ([Feed]) -> Void) -> Void)?

    func fetchFeed(compeltion: @escaping ([Feed]) -> Void) {
        fetchFeedCompeltionCallsCount += 1
        fetchFeedCompeltionReceivedCompeltion = compeltion
        fetchFeedCompeltionReceivedInvocations.append(compeltion)
        fetchFeedCompeltionClosure?(compeltion)
    }

}
class FeedViewTypeMock: FeedViewType {

    //MARK: - emptyFeed

    var emptyFeedCallsCount = 0
    var emptyFeedCalled: Bool {
        return emptyFeedCallsCount > 0
    }
    var emptyFeedClosure: (() -> Void)?

    func emptyFeed() {
        emptyFeedCallsCount += 1
        emptyFeedClosure?()
    }

    //MARK: - append

    var appendFeedCallsCount = 0
    var appendFeedCalled: Bool {
        return appendFeedCallsCount > 0
    }
    var appendFeedReceivedFeed: [Feed]?
    var appendFeedReceivedInvocations: [[Feed]] = []
    var appendFeedClosure: (([Feed]) -> Void)?

    func append(feed: [Feed]) {
        appendFeedCallsCount += 1
        appendFeedReceivedFeed = feed
        appendFeedReceivedInvocations.append(feed)
        appendFeedClosure?(feed)
    }

    //MARK: - showLoading

    var showLoadingCallsCount = 0
    var showLoadingCalled: Bool {
        return showLoadingCallsCount > 0
    }
    var showLoadingClosure: (() -> Void)?

    func showLoading() {
        showLoadingCallsCount += 1
        showLoadingClosure?()
    }

    //MARK: - hideLoading

    var hideLoadingCallsCount = 0
    var hideLoadingCalled: Bool {
        return hideLoadingCallsCount > 0
    }
    var hideLoadingClosure: (() -> Void)?

    func hideLoading() {
        hideLoadingCallsCount += 1
        hideLoadingClosure?()
    }

}
