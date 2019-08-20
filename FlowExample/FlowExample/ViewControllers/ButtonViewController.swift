import UIKit

protocol ButtonViewControllerDelegate: class {
    func actionSelected()
}

final class ButtonViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        button.backgroundColor = UIColor.yellow
        button.setTitle("Trigger action!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        return button
    }()
    private weak var delegate: ButtonViewControllerDelegate?

    init(delegate: ButtonViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(button)
    }

    @objc private func buttonSelected(_ sender: UIButton) {
        delegate?.actionSelected()
    }
}
