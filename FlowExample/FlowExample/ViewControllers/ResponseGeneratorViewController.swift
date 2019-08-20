import UIKit

protocol ResponseGeneratorViewControllerDelegate: class {
    func process(response: Bool)
}

final class ResponseGeneratorViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        button.backgroundColor = UIColor.cyan
        button.setTitle("Simulate response!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        return button
    }()
    private weak var delegate: ResponseGeneratorViewControllerDelegate?

    init(delegate: ResponseGeneratorViewControllerDelegate) {
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
        title = "Response generator"
    }

    @objc private func buttonSelected(_ sender: UIButton) {
        let fakeResponse = Bool.random()
        delegate?.process(response: fakeResponse)
    }
}
