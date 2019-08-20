import UIKit

enum MixedFlowResult: Equatable {
    case canceled(reason: String)
    case completed(success: Bool)
}

final class MixedFlow: Flow {

    typealias FlowResultType = MixedFlowResult

    private let rootController: UINavigationController
    var viewControllerPresenterFactory: ViewControllerPresenterFactory = ViewControllerPresenterFactoryImpl()
    var flowHandler: FlowHandler<MixedFlowResult> = FlowHandler()
    private var initialVCDismisser: ViewControllerDismisser?
    private var confirmationVCDismisser: ViewControllerDismisser?
    var flowInspectable: FlowInspectable {
        return subflowsController
    }
    private let subflowsController: FlowController

    init(rootController: UINavigationController,
         flowController: FlowController = FlowController()) {
        self.rootController = rootController
        self.subflowsController = flowController
    }

    func start() {
        let viewControllerToPresent = ButtonViewController(delegate: self)
        initialVCDismisser = pushPresenter().present(viewController: viewControllerToPresent,
                                                     animated: true,
                                                     completion: {
            self.flowHandler.flowStarted()
        })
    }

    func terminate() {
        initialVCDismisser?.dismiss(animated: false,
                                    completion: nil)
    }

    // MARK: - Private

    private func pushPresenter() -> ViewControllerPresenter {
        return viewControllerPresenterFactory.makePushPresenter(navigationController: rootController)
    }

    private func modalPresenter() -> ViewControllerPresenter {
        return viewControllerPresenterFactory.makeModalPresenter(parent: rootController)
    }
}

extension MixedFlow: ButtonViewControllerDelegate {
    func actionSelected() {
        let shouldStartSubFlow = Bool.random()
        if shouldStartSubFlow {
            let subflow = SimpleNavigationFlow(rootController: rootController)
            subflowsController.start(
                flow: subflow,
                onStarted: {
                    print("Subflow SimpleNavigationFlow started inside MixedFlow.")
            },
                onCompleted: { result, dismisser in
                    switch result {
                    case .error:
                        self.flowHandler.flowFinished(result: .canceled(reason: "Subflow terminated with internal error."),
                                                      dismisser: self.initialVCDismisser)
                    case .success:
                        let confirmationVC = ConfirmResultViewController(delegate: self)
                        self.confirmationVCDismisser =  self.modalPresenter().present(viewController: confirmationVC,
                                                                                      animated: true,
                                                                                      completion: {
                                                                                        print("Confirmation VC has been presented!")
                        })
                    }
            })
        } else {
            flowHandler.flowFinished(result: .canceled(reason: "Should not start sub flow."),
                                     dismisser: initialVCDismisser)
        }
    }
}

extension MixedFlow: ConfirmResultViewControllerDelegate {
    func confirmResult(_ result: Int) {
        confirmationVCDismisser?.dismiss(animated: true,
                                         completion: {
                                            self.flowHandler.flowFinished(result: .completed(success: true),
                                                                          dismisser: self.initialVCDismisser)
        })

    }

    func discardResult() {
        confirmationVCDismisser?.dismiss(animated: true, completion: {
            self.flowHandler.flowFinished(result: .completed(success: false),
                                          dismisser: self.initialVCDismisser)
        })

    }
}
