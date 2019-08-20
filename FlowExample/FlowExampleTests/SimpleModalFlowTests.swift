@testable import FlowExample
import XCTest

final class SimpleModalFlowTests: XCTestCase {

    private var flowStartedCalled = false
    private let rootController = UIViewController()
    private var flowFinishedResult: SimpleModalFlowResult?
    private var flow: SimpleModalFlow!

    override func setUp() {
        super.setUp()
        flow = SimpleModalFlow(rootController: rootController)
        flow.viewControllerPresenterFactory = TestViewControllerPresenterFactory()
        flow.flowHandler = FlowHandler(started: {
            self.flowStartedCalled = true
        },
                                       finished: { result, _ in
            self.flowFinishedResult = result
        })
    }

    func testStartWillCallFlowHandler() {
        flow.start()
        XCTAssertTrue(flowStartedCalled)
    }

    func testStartWillShowButtonVC() {
        flow.start()
        let presentedVC = TestViewControllerModalPresenter.testInstance.stack.last
        XCTAssertTrue(presentedVC is ButtonViewController)
    }

    func testActionSelectedWillCompleteFlow() {
        flow.start()
        flow.actionSelected()
        XCTAssertEqual(flowFinishedResult, .completed)
    }
}
