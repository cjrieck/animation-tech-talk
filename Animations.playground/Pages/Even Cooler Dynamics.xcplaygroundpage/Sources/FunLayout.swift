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
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        let originalRect = collectionView.bounds
        let visibleRect = originalRect.insetBy(dx: -100, dy: -100)
        
        guard let visibleItems = super.layoutAttributesForElements(in: visibleRect) else {
            return
        }
        
        let indexPathsInVisibleRectSet = NSSet(array: visibleItems.map { $0.indexPath })
        let hiddenBehaviors = springAnimator.behaviors.filter { behavior -> Bool in
            if let behavior = behavior as? UIAttachmentBehavior, let attributes = behavior.items.first as? UICollectionViewLayoutAttributes {
                let visible = indexPathsInVisibleRectSet.contains(attributes.indexPath)
                return !visible
            } else {
                return false
            }
        }
        
        hiddenBehaviors.forEach { behavior in
            self.springAnimator.removeBehavior(behavior)
            if let attributes = (behavior as? UIAttachmentBehavior)?.items.first as? UICollectionViewLayoutAttributes {
                self.visibleIndexPaths.remove(attributes.indexPath)
            }
        }
        
        let newlyVisibleItems = visibleItems.filter { attributes -> Bool in
            let currentlyVisible = self.visibleIndexPaths.contains(attributes.indexPath)
            return !currentlyVisible
        }
        
        let touchPoint = collectionView.panGestureRecognizer.location(in: collectionView)
        newlyVisibleItems.forEach { attributes in
            var center = attributes.center
            let attachmentBehavior = self.attachmentBehavior(item: attributes, attachedToAnchor: center)
            
            if CGPoint.zero != touchPoint {
                let yDistanceFromTouch = fabs(touchPoint.y - attachmentBehavior.anchorPoint.y)
                let xDistanceFromTouch = fabs(touchPoint.x - attachmentBehavior.anchorPoint.x)
                let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / ScrollResistance
                
                if lastDelta < 0 {
                    center.y += max(lastDelta, lastDelta * scrollResistance)
                } else {
                    center.y += min(lastDelta, lastDelta * scrollResistance)
                }
                attributes.center = center
            }
            
            self.springAnimator.addBehavior(attachmentBehavior)
            self.visibleIndexPaths.add(attributes.indexPath)
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
                    lastDelta = delta
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
    
    private func attachmentBehavior(item: UIDynamicItem, attachedToAnchor anchor: CGPoint) -> UIAttachmentBehavior {
        let attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: anchor)
        attachmentBehavior.length = 0.0
        attachmentBehavior.damping = 0.8
        attachmentBehavior.frequency = 1.0
        return attachmentBehavior
    }
}
