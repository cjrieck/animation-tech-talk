import UIKit

class ZoomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate let duration = 0.5
    
    let originalFrame: CGRect
    
    var presenting: Bool = true
    
    init(sourceFrame: CGRect) {
        originalFrame = sourceFrame
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let destination = presenting ? toView : fromView
        
        let initialFrame = presenting ? originalFrame : destination.frame
        let finalFrame = presenting ? destination.frame : originalFrame
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            destination.transform = scaleTransform
            destination.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            destination.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: destination)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: presenting ? 0.8 : 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseOut,
            animations: {
                destination.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                destination.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        },
            completion: { finished in
                transitionContext.completeTransition(finished)
        })
    }
}
