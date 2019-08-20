@testable import FlowExample
import UIKit

class TestViewControllerPresenterFactory: ViewControllerPresenterFactory {

    func makeModalPresenter(parent: UIViewController) -> ViewControllerPresenter {
        return TestViewControllerModalPresenter(rootViewController: parent)
    }

    func makePushPresenter(navigationController: UINavigationController) -> NavigationViewControllerPresenter {
        return TestViewControllerPushNavigationPresenter(navigationViewController: navigationController)
    }
}
