import Foundation

class FeedPresenter: FeedPresenterType {

    weak var view: FeedViewType?
    private let service: FeedServiceType

    init(service: FeedServiceType) {
        self.service = service
    }

    func reloadFeed() {
        
    }

    func appendFeed() {

    }
}
