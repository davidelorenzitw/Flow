import XCTest
@testable import FlowExample

class ModalViewControllerPresenterTests: XCTestCase {

    private var presenter: ModalViewControllerPresenter!
    private let screenLoader = FakeScreenLoader()
    private let rootViewController = UIViewController()

    override func setUp() {
        super.setUp()
        screenLoader.setupTopLevelUI(withViewController: rootViewController)
        presenter = ModalViewControllerPresenter(rootViewController: rootViewController)
    }

    override func tearDown() {
        super.tearDown()
        screenLoader.tearDownTopLevelUI()
    }

    func testPresentViewController() {
        let viewControllerToPresent = UIViewController()
        var completionCalled = false
        presenter.present(viewController: viewControllerToPresent,
                          animated: false,
                          completion: {
                              completionCalled = true
        })
        let expectation = XCTestExpectation(description: "The presented VC is not what it is supposed to be, or the completion has not been called")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let presentedVC = self.rootViewController.presentedViewController
            if presentedVC === viewControllerToPresent && completionCalled {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testViewControllerDismisserDismissThePresentedVC() {
        let viewControllerToPresent = UIViewController()
        let dismisser = presenter.present(viewController: viewControllerToPresent,
                                          animated: false,
                                          completion: nil)
        let expectation = XCTestExpectation(description: "The presented VC is not what it is supposed to be")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            dismisser.dismiss(animated: false, completion: {
                let presentedVC = self.rootViewController.presentedViewController
                if presentedVC == nil {
                    expectation.fulfill()
                }
            })
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
