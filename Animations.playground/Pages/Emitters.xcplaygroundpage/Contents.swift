//: [Previous](@previous)

import UIKit
import CoreGraphics
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 350, height: 500)))
containerView.backgroundColor = UIColor.white

let emitterLayer = CAEmitterLayer()
emitterLayer.emitterSize = CGSize(width: 100, height: 100)
emitterLayer.emitterPosition = containerView.center
emitterLayer.emitterShape = kCAEmitterLayerCircle

let emitterCell = CAEmitterCell()
emitterCell.birthRate = 1000
emitterCell.lifetime = 10
emitterCell.velocity = 250
emitterCell.scale = 0.05

emitterCell.emissionRange = CGFloat.pi
let img = colorImage(size: CGSize(width: 5, height: 5))
let nyan = #imageLiteral(resourceName: "nyan.png")
emitterCell.contents = nyan.cgImage
emitterLayer.emitterCells = [emitterCell]

containerView.layer.addSublayer(emitterLayer)

PlaygroundPage.current.liveView = containerView
