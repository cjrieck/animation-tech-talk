import Foundation
import UIKit

public func collisionBehvior(item: UIDynamicItem) -> UICollisionBehavior {
    let collisionBehavior = UICollisionBehavior(items: [item])
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    return collisionBehavior
}
