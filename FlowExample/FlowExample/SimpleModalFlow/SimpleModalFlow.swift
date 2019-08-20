import UIKit

enum SimpleModalFlowResult {
    case completed
}

final class SimpleModalFlow: Flow {

    typealias FlowResultType = SimpleModalFlowResult

    private let rootController: UIViewController
    private var simpleVCDismisser: ViewControllerDismisser?
    var viewControllerPresenterFactory: ViewControllerPresenterFactory = ViewControllerPresenterFactoryImpl()
    var flowHandler: FlowHandler<SimpleModalFlowResult> = FlowHandler()
    let flowInspectable: FlowInspectable = EmptyFlowInspectable()

    init(rootController: UIViewController) {
        self.rootController = rootController
    }

    func start() {
        let viewControllerToPresent = ButtonViewController(delegate: self)
        let viewControllerPresenter = viewControllerPresenterFactory.makeModalPresenter(parent: rootController)
        simpleVCDismisser = viewControllerPresenter.present(viewController: viewControllerToPresent,
                                                            animated: true,
                                                            completion: {
                                                                self.flowHandler.flowStarted()
        })
    }

    func terminate() {
        simpleVCDismisser?.dismiss(animated: false,
                                   completion: nil)
    }
}

extension SimpleModalFlow: ButtonViewControllerDelegate {
    func actionSelected() {
        flowHandler.flowFinished(result: .completed,
                                 dismisser: simpleVCDismisser)
    }
}
