import XCTest
@testable import FlowExample

class ViewControllerPresenterFactoryImplTests: XCTestCase {

    private let factory = ViewControllerPresenterFactoryImpl()

    func testFactoryCreateCorrectModalPresenter() {
        let modalPresenterType = factory.makeModalPresenter(parent: UIViewController())
        XCTAssertTrue(modalPresenterType is ModalViewControllerPresenter)
    }

    func testFactoryCreateCorrectPushNavigationPresenter() {
        let pushNavigationPresenterType = factory.makePushPresenter(navigationController: UINavigationController())
        XCTAssertTrue(pushNavigationPresenterType is PushViewControllerPresenter)
    }
}
