import UIKit
import Lottie
import SnapKit

class ViewController: UIViewController {

    private weak var lottieAnimationView: LOTAnimationView!

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white

        let lottieAnimationView = LOTAnimationView(name: "HappyBirthday")
        view.addSubview(lottieAnimationView)
        self.lottieAnimationView = lottieAnimationView
        lottieAnimationView.snp.makeConstraints { maker in
            maker.center.equalTo(view)
        }
        self.view = view
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lottieAnimationView.play()
    }
}
