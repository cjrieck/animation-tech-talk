import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    fileprivate var animator: UIViewControllerAnimatedTransitioning

    init(animator: UIViewControllerAnimatedTransitioning) {
        self.animator = animator
        super.init()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch animator.self {
        case is ZoomAnimator:
            (self.animator as? ZoomAnimator)?.presenting = operation == .push
            return animator
        case is ScaleAnimator:
            (self.animator as? ScaleAnimator)?.presenting = operation == .push
            return animator
        default:
            return nil
        }
    }
}
