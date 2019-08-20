import UIKit

final class ModalViewControllerPresenter: ViewControllerPresenter {

    private weak var rootViewController: UIViewController?

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    // MARK: - ViewControllerPresenter

    @discardableResult
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> ViewControllerDismisser {
        guard let rootViewController = rootViewController else {
            return EmptyViewControllerDismisser()
        }
        rootViewController.present(viewController, animated: animated, completion: completion)
        return ModalViewControllerDismisser(viewController: viewController)
    }
}
