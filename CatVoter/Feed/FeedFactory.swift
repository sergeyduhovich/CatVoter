import Foundation

struct FeedFactory {
    static func make() -> FeedController {
        let service = FeedService(fetcher: LocalFileFetcher(delay: 0.5))
        let presenter = FeedPresenter(service: service)
        let view = FeedController(presenter: presenter)
        presenter.view = view
        return view
    }
}
