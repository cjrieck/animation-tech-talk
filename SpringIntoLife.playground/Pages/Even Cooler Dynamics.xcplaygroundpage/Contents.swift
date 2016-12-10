//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 350, height: 500)))
containerView.backgroundColor = UIColor.white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = containerView

let collectionViewLayout = FunLayout()
let collectionView = UICollectionView(frame: containerView.frame, collectionViewLayout: collectionViewLayout)
let dataSource = TheDatasource(collectionView: collectionView)
collectionView.dataSource = dataSource
collectionView.delegate = collectionViewLayout
collectionView.backgroundColor = UIColor.white
containerView.addSubview(collectionView)

collectionView.reloadData()
