import UIKit
import SVProgressHUD

class FeedController: UIViewController {

    @IBOutlet private var collection: UICollectionView!
    private let identifier = String(describing: FeedCell.self)

    let presenter: FeedPresenterType

    init(presenter: FeedPresenterType) {
        self.presenter = presenter
        super.init(nibName: String.init(describing: FeedController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
}

private extension FeedController {
    func configureCollectionView() {
        collection.dataSource = self
        collection.delegate = self

        collection.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension FeedController: UICollectionViewDelegate {}

extension FeedController: FeedViewType {
    func emptyFeed() {

    }

    func append(feed: [Feed]) {

    }

    func showLoading() {

    }

    func hideLoading() {

    }
}
