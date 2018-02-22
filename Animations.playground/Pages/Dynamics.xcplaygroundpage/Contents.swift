//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 500)))
containerView.backgroundColor = UIColor.white

let boxSize = 100
let box = UIView(frame: CGRect(x: Int(containerView.center.x - CGFloat(boxSize / 2)), y: 0, width: boxSize, height: boxSize))
box.backgroundColor = UIColor.black
containerView.addSubview(box)

// Make some gravity and boundaries

let animator = UIDynamicAnimator(referenceView: containerView)
let gravity = UIGravityBehavior(items: [box])
let collision = UICollisionBehavior(items: [box])
collision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(collision)
animator.addBehavior(gravity)

let barrier = UIView(frame: CGRect(x: 0, y: 250, width: 130, height: 50))
barrier.backgroundColor = UIColor.blue
containerView.addSubview(barrier)

// Create invisible boundary to prevent the blue view from going down with the box

let rightTopMostPoint = CGPoint(x: barrier.frame.origin.x + barrier.frame.size.width, y: barrier.frame.origin.y)
collision.addBoundary(withIdentifier: "topBarrier" as NSCopying, from: barrier.frame.origin, to: rightTopMostPoint)

let rightBottomMostPoint = CGPoint(x: rightTopMostPoint.x, y: rightTopMostPoint.y + barrier.frame.size.height)
collision.addBoundary(withIdentifier: "bottomBarrier" as NSCopying, from: barrier.frame.origin, to: rightBottomMostPoint)

// Make the box bouncy!

let dynamicBehavior = UIDynamicItemBehavior(items: [box])
dynamicBehavior.elasticity = 0.6
animator.addBehavior(dynamicBehavior)

PlaygroundPage.current.liveView = containerView

//: [Next](@next)
