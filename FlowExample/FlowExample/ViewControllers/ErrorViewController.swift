import UIKit

protocol ErrorViewControllerDelegate: class {
    func buttonSelectedFromError()
}

final class ErrorViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        button.backgroundColor = UIColor.red
        button.setTitle("Terminate flow with error!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        return button
    }()
    private weak var delegate: ErrorViewControllerDelegate?

    init(delegate: ErrorViewControllerDelegate) {
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
        title = "Error!"
    }

    @objc private func buttonSelected(_ sender: UIButton) {
        delegate?.buttonSelectedFromError()
    }
}
