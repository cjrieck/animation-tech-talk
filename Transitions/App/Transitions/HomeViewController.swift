import UIKit
import SnapKit

private let CellReuseIdentifier = "cell"

class HomeViewController: UIViewController {
    
    fileprivate struct Constants {
        static let ZoomTitle = "ZOOOOOOMMMMM"
        static let ZoomDescription = "This was the amazing zoom animation (just like the superhero)"
        static let ScaleTitle = "Swoosh!"
        static let ScaleDescription = "And here you witnessed a scaling problem being solved"
        static let MaskTitle = "WOWZA! AMAZE!"
        static let MaskDescription = "Ever wonder what was behind curtain number 3? Now you know!"
    }
    
    fileprivate var currentNavControllerDelegate: UINavigationControllerDelegate?
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.itemSize = CGSize(width: 70, height: 70)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view).inset(10.0)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        let navDelegate: UINavigationControllerDelegate?
        let title: String?
        let animationDescription: String?
        switch indexPath.item {
        case 0:
            let collectionViewCellFrame = cell.superview!.convert(cell.frame, to: nil)
            navDelegate = NavigationControllerDelegate(animator: ZoomAnimator(sourceFrame: collectionViewCellFrame))
            title = Constants.ZoomTitle
            animationDescription = Constants.ZoomDescription
        case 1:
            navDelegate = NavigationControllerDelegate(animator: ScaleAnimator())
            title = Constants.ScaleTitle
            animationDescription = Constants.ScaleDescription
        case 2:
            navDelegate = NavigationControllerDelegate(animator: CircleMaskAnimator())
            title = Constants.MaskTitle
            animationDescription = Constants.MaskDescription
        default:
            title = nil
            animationDescription = nil
            navDelegate = nil
        }
        
        let destinationVC = DestinationViewController(animationDescription: animationDescription)
        destinationVC.title = title
        destinationVC.view.backgroundColor = cell.backgroundColor
        
        currentNavControllerDelegate = navDelegate
        navigationController?.delegate = navDelegate
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}
