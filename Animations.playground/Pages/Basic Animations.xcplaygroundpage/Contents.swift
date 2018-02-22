//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = CirclesView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))

let allTogetherNow = true
let duration = 6
for i in 0..<containerView.subviews.count {
    let view = containerView.subviews[i]
    UIView.animate(withDuration: TimeInterval(duration),
                   delay: allTogetherNow ? 0 : TimeInterval(i * duration),
                   options: animationOption(option: i),
                   animations: {
                       view.transform = CGAffineTransform.identity
                   },
                   completion: nil)
}

PlaygroundPage.current.liveView = containerView

//: [Next](@next)
