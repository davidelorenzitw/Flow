@testable import FlowExample
import XCTest

class PopViewControllerDismisserTests: XCTestCase {

    private var dismisser: PopViewControllerDismisser!
    private let screenLoader = FakeScreenLoader()
    private let rootNavigationVC = UINavigationController()
    private let parentViewController = UIViewController()
    private let presentedViewController = UIViewController()

    override func setUp() {
        super.setUp()
        screenLoader.setupTopLevelUI(withViewController: rootNavigationVC)
        rootNavigationVC.pushViewController(parentViewController, animated: false)
        rootNavigationVC.pushViewController(presentedViewController, animated: false)
        dismisser = PopViewControllerDismisser(viewController: presentedViewController)
    }

    override func tearDown() {
        super.tearDown()
        screenLoader.tearDownTopLevelUI()
    }

    func testDismiss() {
        var completionCalled = false
        dismisser.dismiss(animated: false,
                          completion: {
                              completionCalled = true
        })
        let expectation = XCTestExpectation(description: "The presented VC is not what it is supposed to be, or the completion has not been called")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let lastNavigationVC = self.rootNavigationVC.viewControllers.last
            if lastNavigationVC !== self.presentedViewController && completionCalled {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
