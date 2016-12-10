import UIKit

private let ScrollResistance: CGFloat = 1000

public class FunLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    fileprivate var springAnimator: UIDynamicAnimator!
    fileprivate var visibleIndexPaths: NSMutableSet!
    fileprivate var lastDelta: CGFloat = 0.0
    
    override public init() {
        super.init()
        itemSize = CGSize(width: 50, height: 50)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        
        springAnimator = UIDynamicAnimator(collectionViewLayout: self)
        visibleIndexPaths = NSMutableSet()
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView,
            let visibleItems = super.layoutAttributesForElements(in: CGRect(origin: CGPoint.zero, size: collectionView.contentSize)) else {
                return
        }
        
        if springAnimator.behaviors.count == 0 {
            visibleItems.forEach({ item in
                let attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                attachmentBehavior.length = 0.0
                attachmentBehavior.damping = 0.8
                attachmentBehavior.frequency = 1.0
                
                self.springAnimator.addBehavior(attachmentBehavior)
            })
        }
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = self.collectionView else {
            return false
        }
        
        let delta = newBounds.origin.y - (collectionView as UIScrollView).bounds.origin.y
        let touchPoint = collectionView.panGestureRecognizer.location(in: collectionView)
        springAnimator.behaviors.forEach { item in
            if let springBehavior = item as? UIAttachmentBehavior {
                let yDistanceFromTouch = fabs(touchPoint.y - springBehavior.anchorPoint.y)
                let xDistanceFromTouch = fabs(touchPoint.x - springBehavior.anchorPoint.x)
                let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / ScrollResistance
                
                if let layoutAttributes = springBehavior.items.first {
                    var center = layoutAttributes.center
                    if delta < 0 {
                        center.y += max(delta, delta * scrollResistance)
                    } else {
                        center.y += min(delta, delta * scrollResistance)
                    }
                    layoutAttributes.center = center
                    self.springAnimator.updateItem(usingCurrentState: layoutAttributes)
                }
            }
        }
        
        return false
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return springAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return springAnimator.layoutAttributesForCell(at: indexPath)
    }
}
