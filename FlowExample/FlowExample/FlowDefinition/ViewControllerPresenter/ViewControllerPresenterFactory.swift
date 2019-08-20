import UIKit

protocol ViewControllerPresenterFactory {
    func makeModalPresenter(parent: UIViewController) -> ViewControllerPresenter
    func makePushPresenter(navigationController: UINavigationController) -> NavigationViewControllerPresenter
}

final class ViewControllerPresenterFactoryImpl: ViewControllerPresenterFactory {

    func makeModalPresenter(parent: UIViewController) -> ViewControllerPresenter {
        return ModalViewControllerPresenter(rootViewController: parent)
    }

    func makePushPresenter(navigationController: UINavigationController) -> NavigationViewControllerPresenter {
        return PushViewControllerPresenter(navigationViewController: navigationController)
    }
}
