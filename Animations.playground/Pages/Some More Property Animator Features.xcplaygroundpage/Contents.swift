//: [Previous](@previous)
import UIKit
import PlaygroundSupport

let containerView = CirclesView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))

let box = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
box.backgroundColor = UIColor.blue
box.center = CGPoint(x: 0, y: containerView.center.y)
containerView.addSubview(box)

let positionAnimator = UIViewPropertyAnimator(duration: 5, curve: .linear, animations: {
    box.center = CGPoint(x: containerView.frame.size.width, y: box.center.y)
})

positionAnimator.addAnimations({ box.alpha = 0 }, delayFactor: 0.5)
positionAnimator.addAnimations({ box.center = .zero }, delayFactor: 0.75)
positionAnimator.startAnimation()

PlaygroundPage.current.liveView = containerView

//: [Next](@next)
