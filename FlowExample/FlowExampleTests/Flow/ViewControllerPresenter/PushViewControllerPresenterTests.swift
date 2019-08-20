import XCTest
@testable import FlowExample

class PushViewControllerPresenterTests: XCTestCase {

    private var presenter: PushViewControllerPresenter!
    private let screenLoader = FakeScreenLoader()
    private let rootViewController = UINavigationController()

    override func setUp() {
        super.setUp()
        screenLoader.setupTopLevelUI(withViewController: rootViewController)
        presenter = PushViewControllerPresenter(navigationViewController: rootViewController)
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
            let presentedVC = self.rootViewController.viewControllers.last
            if presentedVC === viewControllerToPresent && completionCalled {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testViewControllerStackPreserved() {
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        rootViewController.viewControllers = [firstVC, secondVC]
        let thirdVC = UIViewController()
        presenter.keepOnlyLastViewControllerOnStack = false
        presenter.present(viewController: thirdVC,
                          animated: false,
                          completion: nil)
        XCTAssertEqual(rootViewController.viewControllers.count, 3)
    }

    func testViewControllerStackRemoved() {
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        rootViewController.viewControllers = [firstVC, secondVC]
        let thirdVC = UIViewController()
        presenter.keepOnlyLastViewControllerOnStack = true
        presenter.present(viewController: thirdVC,
                          animated: false,
                          completion: nil)
        XCTAssertEqual(rootViewController.viewControllers.count, 1)
    }

    func testViewControllerDismisserDismissPresentedVC() {
        let firstVC = UIViewController()
        rootViewController.viewControllers = [firstVC]
        let viewControllerToPresent = UIViewController()
        presenter.keepOnlyLastViewControllerOnStack = false
        let dismisser = presenter.present(viewController: viewControllerToPresent,
                                          animated: false,
                                          completion: nil)
        let expectation = XCTestExpectation(description: "The presented VC is not what it is supposed to be.")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            dismisser.dismiss(animated: false, completion: {
                let presentedVC = self.rootViewController.viewControllers.last
                if presentedVC === firstVC {
                    expectation.fulfill()
                }
            })
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
