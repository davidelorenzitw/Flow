import UIKit

class FakeScreenLoader<T: UIViewController> {

    private var rootWindow: UIWindow!

    func setupTopLevelUI(withViewController viewController: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = viewController
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }

    func tearDownTopLevelUI() {
        guard let rootViewController = rootWindow.rootViewController as? T else {
            fatalError("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
        }
        rootViewController.viewWillDisappear(false)
        rootViewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        rootWindow = nil
    }
}
