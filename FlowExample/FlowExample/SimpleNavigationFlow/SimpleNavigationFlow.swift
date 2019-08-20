import UIKit

enum SimpleNavigationFlowResult {
    case success
    case error
}

final class SimpleNavigationFlow: Flow {

    typealias FlowResultType = SimpleNavigationFlowResult

    private let rootController: UINavigationController
    var viewControllerPresenterFactory: ViewControllerPresenterFactory = ViewControllerPresenterFactoryImpl()
    private var responseGeneratorVCDismisser: ViewControllerDismisser?
    private var responseVCDismisser: ViewControllerDismisser?
    var flowHandler: FlowHandler<SimpleNavigationFlowResult> = FlowHandler()
    let flowInspectable: FlowInspectable = EmptyFlowInspectable()

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    func start() {
        let viewControllerToPresent = ResponseGeneratorViewController(delegate: self)
        responseGeneratorVCDismisser = pushPresenter().present(viewController: viewControllerToPresent,
                                                               animated: true,
                                                               completion: {
                                                                self.flowHandler.flowStarted()
        })
    }

    func terminate() {

    }

    // MARK: - Private

    private func pushPresenter() -> ViewControllerPresenter {
        return viewControllerPresenterFactory.makePushPresenter(navigationController: rootController)
    }
}

extension SimpleNavigationFlow: ResponseGeneratorViewControllerDelegate {
    func process(response: Bool) {
        if response {
            let successVC = SuccessViewController(delegate: self)
            responseVCDismisser = pushPresenter().present(viewController: successVC,
                                                          animated: true,
                                                          completion: nil)
        } else {
            let errorVC = ErrorViewController(delegate: self)
            responseVCDismisser = pushPresenter().present(viewController: errorVC,
                                                          animated: true,
                                                          completion: nil)
        }
    }
}

extension SimpleNavigationFlow: SuccessViewControllerDelegate {
    func buttonSelectedFromSuccess() {
        flowHandler.flowFinished(result: .success,
                                 dismisser: responseGeneratorVCDismisser)
    }
}

extension SimpleNavigationFlow: ErrorViewControllerDelegate {
    func buttonSelectedFromError() {
        flowHandler.flowFinished(result: .error,
                                 dismisser: responseGeneratorVCDismisser)
    }
}
