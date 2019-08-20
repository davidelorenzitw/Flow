@testable import FlowExample
import UIKit

class TestViewControllerModalPresenter: ViewControllerPresenter {

    static var testInstance: TestViewControllerModalPresenter!

    var stack: [UIViewController]

    init(rootViewController: UIViewController) {
        stack = []
        stack.append(rootViewController)
        TestViewControllerModalPresenter.testInstance = self
    }

    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> ViewControllerDismisser {
        stack.append(viewController)
        completion?()
        return FakeViewControllerDismisser(onDismiss: {
            self.stack = self.stack.keepOnlyBefore(viewController: viewController)
        })
    }
}
