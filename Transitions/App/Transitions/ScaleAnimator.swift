import UIKit

class ScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.3
    private let destinationAlhpa: CGFloat = 0.7
    private let destinationScaleFactor: CGFloat = 0.9
    
    var presenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        
        let destination = presenting ? toView : fromView
        let source = presenting ? fromView : toView
        
        containerView.addSubview(source)
        containerView.addSubview(destination)
        
        destination.transform = presenting ? CGAffineTransform(translationX: destination.frame.size.width, y: 0.0) : .identity
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                            source.alpha = self.presenting ? self.destinationAlhpa : 1.0
                            source.transform = self.presenting ? CGAffineTransform(scaleX: self.destinationScaleFactor, y: self.destinationScaleFactor) : .identity
                            destination.transform = self.presenting ? .identity : CGAffineTransform(translationX: destination.frame.size.width, y: 0.0)
                        }) { finished in
                            transitionContext.completeTransition(finished)
        }
    }
    
}
