import Foundation
import UIKit

final class RootViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        return view
    }()

    private let dataSource: [String] = ["One screen modal flow",
                                        "Two screens navigation flow",
                                        "Mixed flow with internal subflow"]
    private let flowController = FlowController()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        pinToEdges(contentView: tableView)
        title = "Flow examples"
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            startSimpleModalFlow()
        case 1:
            startSimpleNavigationFlow()
        case 2:
            startMixedFlow()

        default:
            break
        }
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension RootViewController {

    private func startSimpleModalFlow() {
        let flow = SimpleModalFlow(rootController: self)
        flowController.start(flow: flow)
    }

    private func startSimpleNavigationFlow() {
        guard let rootNavigationController = navigationController else {
            return
        }
        let flow = SimpleNavigationFlow(rootController: rootNavigationController)
        flowController.start(flow: flow,
                             onStarted: {
                                print("SimpleNavigationFlow has started!!!")
        },
                             onCompleted: { (result, dismisser) in
                                dismisser?.dismiss(animated: true, completion: {
                                    let message: String
                                    switch result {
                                    case .success: message = "Simple navigation flow completed with SUCCESS!"
                                    case .error: message = "Simple navigation flow completed with ERROR!"
                                    }
                                    let alert = UIAlertController(title: "Simple navigation flow", message: message, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                                    self.present(alert, animated: true, completion: nil)
                                })
        })
    }

    private func startMixedFlow() {
        guard let rootNavigationController = navigationController else {
            return
        }
        let flow = MixedFlow(rootController: rootNavigationController)
        flowController.start(flow: flow,
                             onCompleted: { result, dismisser in
                                switch result {
                                case let .completed(success: success):
                                    dismisser?.dismiss(animated: true, completion: {
                                        print("Mixed flow completed with success: \(success)")
                                    })
                                case let .canceled(reason: reason):
                                    dismisser?.dismiss(animated: true, completion: {
                                        print("Mixed flow canceled with reason: \(reason)")
                                    })
                                }
        })
    }
}
