import UIKit

final class PushViewControllerPresenter: NavigationViewControllerPresenter {

    private weak var navigationViewController: UINavigationController?
    var keepOnlyLastViewControllerOnStack = false

    init(navigationViewController: UINavigationController) {
        self.navigationViewController = navigationViewController
    }

    // MARK: - NavigationViewControllerPresenter

    @discardableResult
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> ViewControllerDismisser {
        guard let navigationViewController = navigationViewController else {
            return EmptyViewControllerDismisser()
        }
        if keepOnlyLastViewControllerOnStack {
            navigationViewController.setViewControllers([viewController], animated: animated, completion: completion)
        } else {
            navigationViewController.pushViewController(viewController, animated: animated, completion: completion)
        }
        return PopViewControllerDismisser(viewController: viewController)
    }
}
