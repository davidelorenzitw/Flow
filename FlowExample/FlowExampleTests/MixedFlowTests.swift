@testable import FlowExample
import XCTest

final class MixedFlowTests: XCTestCase {

    private var flowStartedCalled = false
    private let rootController = UINavigationController()
    private var flowFinishedResult: MixedFlowResult?
    private var flow: MixedFlow!

    override func setUp() {
        super.setUp()
        flow = MixedFlow(rootController: rootController)
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

    func testStartWillShowButtonVC() throws {
        flow.start()
        let presentedVC = rootController.viewControllers.last
        XCTAssertTrue(presentedVC is ButtonViewController)
    }

    func testActionSelectedWillEventuallyStartSubFlow() {
        flow.start()
        flow.actionSelected()
        if flowFinishedResult == nil {
            XCTAssertTrue(flow.flowInspectable.activeSubFlowResultType == SimpleNavigationFlowResult.self)
        }
    }
}
