//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 500, height: 500)))
containerView.backgroundColor = UIColor.white

let interactiveView = InteractiveView(frame: containerView.frame)
containerView.addSubview(interactiveView)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = containerView

//: [Next](@next)
