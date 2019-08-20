import UIKit

final class ModalViewControllerDismisser: ViewControllerDismisser {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: - ViewControllerDismisser

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let viewController = viewController else {
            completion?()
            return
        }
        viewController.presentingViewController?.dismiss(animated: animated, completion: completion)
    }
}
