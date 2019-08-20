import UIKit

protocol ViewControllerDismisser {
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

protocol ViewControllerPresenter {
    @discardableResult
    func present(viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) -> ViewControllerDismisser
}

protocol NavigationViewControllerPresenter: ViewControllerPresenter {
    var keepOnlyLastViewControllerOnStack: Bool { get set }
}
