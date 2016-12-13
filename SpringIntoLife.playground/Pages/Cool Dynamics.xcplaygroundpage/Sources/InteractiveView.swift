import UIKit

public class InteractiveView: UIView {
    
    var box: UIView!
    var animator: UIDynamicAnimator!
    
    var snapBehavior: UISnapBehavior?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let box = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        box.backgroundColor = UIColor.orange
        box.center = center
        addSubview(box)
        self.box = box
        
        let animator = UIDynamicAnimator(referenceView: self)
        
        animator.addBehavior(collisionBehvior(item: box))
        
        let attachmentBehavior = UISnapBehavior(item: box, snapTo: center)
        attachmentBehavior.damping = 0.6
        animator.addBehavior(attachmentBehavior)
        self.animator = animator
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else {
            return
        }
        let snapBehavior = UISnapBehavior(item: box, snapTo: touchLocation)
        animator.addBehavior(snapBehavior)
        self.snapBehavior = snapBehavior
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior, let touchLocation = touches.first?.location(in: self) {
            snapBehavior.snapPoint = touchLocation
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior {
            animator.removeBehavior(snapBehavior)
        }
        snapBehavior = nil
    }
    
}

