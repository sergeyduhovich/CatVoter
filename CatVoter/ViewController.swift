import UIKit

class ViewController: UIViewController {

    let fetcher: FetcherProtocol

    init(fetcher: FetcherProtocol = LocalFileFetcher()) {
        self.fetcher = fetcher
        super.init(nibName: String(describing: ViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
