//: [Previous](@previous)

import UIKit
import PlaygroundSupport

func colorImage(size: CGSize) -> CGImage? {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(UIColor.red.cgColor)
    context?.fill(rect)
    let cgImg = context?.makeImage()
    UIGraphicsEndImageContext()
    return cgImg
}

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 350, height: 500)))
containerView.backgroundColor = UIColor.white

let emitterLayer = CAEmitterLayer()
emitterLayer.emitterSize = CGSize(width: 100, height: 100)
emitterLayer.emitterPosition = containerView.center
emitterLayer.emitterShape = kCAEmitterLayerPoint

let emitterCell = CAEmitterCell()
emitterCell.birthRate = 100
emitterCell.lifetime = 10
emitterCell.velocity = 250
emitterCell.scale = 0.3
emitterCell.scaleSpeed = 0.5
emitterCell.alphaRange = 100
emitterCell.alphaSpeed = 1

emitterCell.emissionRange = CGFloat.pi
let img = colorImage(size: CGSize(width: 5, height: 5))
emitterCell.contents = img
emitterLayer.emitterCells = [emitterCell]

containerView.layer.addSublayer(emitterLayer)

PlaygroundPage.current.liveView = containerView

//: [Next](@next)
