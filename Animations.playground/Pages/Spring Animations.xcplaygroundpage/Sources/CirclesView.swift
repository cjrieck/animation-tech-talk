import Foundation
import UIKit

private let CircleSize: CGFloat = 100

public class CirclesView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        let xPositionPadding: CGFloat = 10
        let yPositionPadding: CGFloat = 25
        for i in 0..<3 {
            let newX: CGFloat
            if i == 1 {
                newX = center.x - (CircleSize / 2)
            } else if i == 2 {
                newX = frame.size.width - (CircleSize + xPositionPadding)
            } else {
                newX = (CircleSize * CGFloat(i)) + xPositionPadding
            }
            let circle = circleView(frame: CGRect(x: newX, y: yPositionPadding, width: CircleSize, height: CircleSize))
            
            addSubview(circle)
            circle.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func circleView(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = CircleSize / 2
        return view
    }
}
