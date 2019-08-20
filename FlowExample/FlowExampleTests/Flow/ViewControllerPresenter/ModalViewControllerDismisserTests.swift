@testable import FlowExample
import XCTest

class ModalViewControllerDismisserTests: XCTestCase {

    private var dismisser: ModalViewControllerDismisser!
    private let screenLoader = FakeScreenLoader()
    private let parentViewController = UIViewController()
    private let presentedViewController = UIViewController()

    override func setUp() {
        super.setUp()
        screenLoader.setupTopLevelUI(withViewController: parentViewController)
        parentViewController.present(presentedViewController, animated: false)
        dismisser = ModalViewControllerDismisser(viewController: presentedViewController)
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
            let presentedVC = self.parentViewController.presentedViewController
            if presentedVC == nil && completionCalled {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
