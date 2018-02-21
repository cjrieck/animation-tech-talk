import UIKit

public func colorImage(size: CGSize) -> CGImage? {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(UIColor.red.cgColor)
    context?.fill(rect)
    let cgImg = context?.makeImage()
    UIGraphicsEndImageContext()
    return cgImg
}
