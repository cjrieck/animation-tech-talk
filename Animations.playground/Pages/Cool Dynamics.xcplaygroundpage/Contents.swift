//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 500, height: 500)))
containerView.backgroundColor = UIColor.white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = containerView

let interactiveView = InteractiveView(frame: containerView.frame)
containerView.addSubview(interactiveView)

//: [Next](@next)
