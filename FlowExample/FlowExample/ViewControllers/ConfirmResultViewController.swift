import UIKit

protocol ConfirmResultViewControllerDelegate: class {
    func discardResult()
    func confirmResult(_ result: Int)
}

final class ConfirmResultViewController: UIViewController {

    private lazy var discardButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        button.backgroundColor = UIColor.red
        button.setTitle("Disard result", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(discardButtonSelected(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var confirmButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 200, width: 300, height: 50))
        button.backgroundColor = UIColor.green
        button.setTitle("Confirm result", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(confirmButtonSelected(_:)), for: .touchUpInside)
        return button
    }()
    private weak var delegate: ConfirmResultViewControllerDelegate?

    init(delegate: ConfirmResultViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(discardButton)
        view.addSubview(confirmButton)
        title = "Confirm result"
    }

    @objc private func discardButtonSelected(_ sender: UIButton) {
        delegate?.discardResult()
    }

    @objc private func confirmButtonSelected(_ sender: UIButton) {
        let randomResult = Int.random(in: 1...10)
        delegate?.confirmResult(randomResult)
    }
}
