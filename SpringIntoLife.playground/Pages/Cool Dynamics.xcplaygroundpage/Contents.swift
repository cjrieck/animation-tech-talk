//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 500, height: 500)))
containerView.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

containerView.addSubview(InteractiveView(frame: containerView.frame))

//: [Next](@next)
