import UIKit

private let CircleMaskAnimationKey = "circleMaskAnimation"
private let CircleDefaultMaxScale = 2.5
private let CircleDefaultMinScale = 0.0

class CircleMaskAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    var presenting: Bool = true
    
    private let duration = 0.5
    
    private weak var maskedView: UIView?
    private weak var transitionContext: UIViewControllerContextTransitioning?
    
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
        
        let bounds = source.bounds
        let circleMaskLayer = CAShapeLayer()
        circleMaskLayer.frame = bounds
        
        let radius = circleStartingRadius(with: source)
        let circleCenter = circleCenterPoint(with: source)
        circleMaskLayer.position = circleCenter
        let circleBoundingRect = CGRect(x: circleCenter.x - radius, y: circleCenter.y - radius, width: radius * 2, height: radius * 2)
        circleMaskLayer.path = UIBezierPath(ovalIn: circleBoundingRect).cgPath
        circleMaskLayer.bounds = circleBoundingRect
        
        let circleMaskAnimation = CABasicAnimation(keyPath: "transform.scale")
        circleMaskAnimation.duration = duration
        circleMaskAnimation.repeatCount = 1
        circleMaskAnimation.isRemovedOnCompletion = false
        circleMaskAnimation.delegate = self
        circleMaskAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.34, 0.01, 0.69, 1.37)
        circleMaskAnimation.fillMode = kCAFillModeForwards
        
        circleMaskAnimation.fromValue = presenting ? CircleDefaultMinScale : CircleDefaultMaxScale
        circleMaskAnimation.toValue = presenting ? CircleDefaultMaxScale : CircleDefaultMinScale
        
        destination.layer.mask = circleMaskLayer
        destination.layer.masksToBounds = true
        circleMaskLayer.add(circleMaskAnimation, forKey: CircleMaskAnimationKey)
        maskedView = destination
        
        containerView.addSubview(source)
        containerView.addSubview(destination)
        self.transitionContext = transitionContext
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        maskedView?.layer.mask = nil
        maskedView = nil
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(flag)
    }
    
    private func circleCenterPoint(with fromView: UIView) -> CGPoint {
        let center = CGPoint(x: fromView.bounds.origin.x + fromView.bounds.size.width / 2, y: fromView.bounds.origin.y + fromView.bounds.size.height / 2)
        return center
    }
    
    private func circleStartingRadius(with fromView: UIView) -> CGFloat {
        let bounds = fromView.bounds
        let diameter = min(bounds.size.height, bounds.size.width)
        let radius = diameter / 2
        return radius
    }
}
