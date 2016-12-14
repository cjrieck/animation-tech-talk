import UIKit

private let CellIdentifier = "cell"

public class TheDatasource: NSObject, UICollectionViewDataSource {
    
    private weak var collectionView: UICollectionView!
    
    public init(collectionView: UICollectionView) {
        super.init()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        self.collectionView = collectionView
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}

