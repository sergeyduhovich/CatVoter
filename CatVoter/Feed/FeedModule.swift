import UIKit

protocol FeedViewType: class {
    func emptyFeed()
    func append(feed: [Feed])
    func showLoading()
    func hideLoading()
}

protocol FeedPresenterType {
    func reloadFeed()
    func appendFeed()
}

protocol FeedServiceType {
    func fetchFeed(compeltion: @escaping ([Feed]) -> Void)
}

struct Feed {
    let url: URL
    let image: UIImage?
    let size: CGSize
}
