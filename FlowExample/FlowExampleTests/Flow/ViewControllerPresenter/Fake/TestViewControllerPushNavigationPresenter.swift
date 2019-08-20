@testable import FlowExample
import UIKit

class TestViewControllerPushNavigationPresenter: NavigationViewControllerPresenter {

    public static var testInstance: TestViewControllerPushNavigationPresenter!

    var root: UINavigationController
    var keepOnlyLastViewControllerOnStack = false

    init(navigationViewController: UINavigationController) {
        root = navigationViewController
        TestViewControllerPushNavigationPresenter.testInstance = self
    }

    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> ViewControllerDismisser {
        if keepOnlyLastViewControllerOnStack {
            root.viewControllers.removeAll()
        }
        root.viewControllers.append(viewController)
        completion?()
        return FakeViewControllerDismisser(onDismiss: {
            self.root.viewControllers = self.root.viewControllers.keepOnlyBefore(viewController: viewController)
        })
    }
}
