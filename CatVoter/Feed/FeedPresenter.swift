import Foundation

class FeedPresenter: FeedPresenterType {

    weak var view: FeedViewType?
    private let service: FeedServiceType

    init(service: FeedServiceType) {
        self.service = service
    }

    func reloadFeed() {
        view?.showLoading()

        service.fetchFeed { [weak self] feed in
            self?.view?.hideLoading()
        }
    }

    func appendFeed() {

    }
}
