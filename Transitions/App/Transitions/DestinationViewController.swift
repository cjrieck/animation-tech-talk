import UIKit
import SnapKit

class DestinationViewController: UIViewController {
    
    fileprivate let animationDescription: String?
    
    init(animationDescription: String?) {
        self.animationDescription = animationDescription
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        
        let label = UILabel()
        label.text = animationDescription
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.centerY.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
