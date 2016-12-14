import Foundation
import UIKit

public func animationOption(option: Int) -> UIViewAnimationOptions {
    let animationOptions: UIViewAnimationOptions
    switch option {
    case 0:
        animationOptions = .curveLinear
    case 1:
        animationOptions = .curveEaseOut
    case 2:
        animationOptions = .curveEaseIn
    default:
        animationOptions = .curveEaseInOut
    }
    return animationOptions
}
