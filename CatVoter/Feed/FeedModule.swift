import UIKit

// sourcery: AutoMockable
protocol FeedViewType: class {
    func emptyFeed()
    func append(feed: [Feed])
    func showLoading()
    func hideLoading()
}

// sourcery: AutoMockable
protocol FeedPresenterType {
    func reloadFeed()
    func appendFeed()
}

// sourcery: AutoMockable
protocol FeedServiceType {
    func fetchFeed(compeltion: @escaping ([Feed]) -> Void)
}

struct Feed {
    let url: URL
    let image: UIImage?
    let size: CGSize
}
