//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = CirclesView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))

let allTogetherNow = true
let duration = 4
for i in 0..<containerView.subviews.count {
    let view = containerView.subviews[i]
    let damping = 1.0 - (0.25 * CGFloat(i + 1))
    UIView.animate(withDuration: TimeInterval(duration),
                   delay: allTogetherNow ? 0 : TimeInterval(i * duration),
                   options: animationOption(option: i),
                   animations: {
                        view.transform = CGAffineTransform.identity
                    },
                   completion: nil)
}

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
