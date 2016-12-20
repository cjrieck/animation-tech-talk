import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    fileprivate var animator: UIViewControllerAnimatedTransitioning & TransitionAnimating

    init(animator: UIViewControllerAnimatedTransitioning & TransitionAnimating) {
        self.animator = animator
        super.init()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = operation == .push
        return animator
    }
}
