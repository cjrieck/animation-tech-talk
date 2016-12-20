import UIKit
import SnapKit

private let CellReuseIdentifier = "cell"

class HomeViewController: UIViewController {
    
    fileprivate var currentNavControllerDelegate: UINavigationControllerDelegate?
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        setupCollectionView()
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
        let destinationVC = UIViewController()
        destinationVC.view.backgroundColor = cell.backgroundColor
        switch indexPath.item {
        case 0:
            let collectionViewCellFrame = cell.superview!.convert(cell.frame, to: nil)
            navDelegate = NavigationControllerDelegate(animator: ZoomAnimator(sourceFrame: collectionViewCellFrame))
        case 1:
            navDelegate = NavigationControllerDelegate(animator: ScaleAnimator())
        case 2:
            navDelegate = NavigationControllerDelegate(animator: CircleMaskAnimator())
        default:
            navDelegate = nil
        }
        
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
