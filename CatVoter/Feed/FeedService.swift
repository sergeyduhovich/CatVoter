import Foundation

class FeedService {

    let fetcher: FetcherProtocol
    
    init(fetcher: FetcherProtocol) {
        self.fetcher = fetcher
    }
}

extension FeedService: FeedServiceType {
    func fetchFeed(compeltion: @escaping ([Feed]) -> Void) {

    }
}
