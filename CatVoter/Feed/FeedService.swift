import Foundation
import TheCatsAPI

class FeedService {

    let api = TheCatsAPI(apiKey: "29f610a4-70f1-4df5-b33f-40d9e3acf41f")
    
    init() {
        api.images { images in
            print(images)
        }
    }
}

extension FeedService: FeedServiceType {
    func fetchFeed(compeltion: @escaping ([Feed]) -> Void) {

    }
}
