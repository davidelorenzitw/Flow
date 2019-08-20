import UIKit

final class PopViewControllerDismisser: ViewControllerDismisser {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: - ViewControllerDismisser

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let viewController = viewController,
            let navigationController = viewController.navigationController else {
            completion?()
            return
        }

        if isPresentedAsFirst(viewController: viewController,
                              onNavigationController: navigationController) {
            navigationController.setViewControllers([], animated: animated, completion: completion)
        } else {
            guard let previousVC = viewControllerOnStackBefore(viewController: viewController,
                                                               navigationController: navigationController) else {
                completion?()
                return
            }
            navigationController.popToViewController(previousVC,
                                                     animated: animated,
                                                     completion: completion)
        }
    }

    // MARK: - Private

    private func isPresentedAsFirst(viewController: UIViewController,
                                    onNavigationController navigationController: UINavigationController) -> Bool {
        guard let firstVCOnStack = navigationController.viewControllers.first else {
            return false
        }
        return firstVCOnStack == viewController
    }

    private func viewControllerOnStackBefore(viewController: UIViewController,
                                             navigationController: UINavigationController) -> UIViewController? {
        guard let viewControllerIndex = navigationController.viewControllers.firstIndex(where: { $0 == viewController }) else {
            return nil
        }
        let previousVCIndex = max(0, viewControllerIndex - 1)
        return navigationController.viewControllers[previousVCIndex]
    }
}
