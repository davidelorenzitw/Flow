@testable import FlowExample
import XCTest

class FlowHandlerTests: XCTestCase {

    private var flowHandler: FlowHandler<Int>!

    func testFlowStartedCallbackCalled() {
        var startCalled = false
        flowHandler = FlowHandler(started: {
            startCalled = true
        })
        flowHandler.flowStarted()
        XCTAssertTrue(startCalled)
    }

    func testFlowFinishedCallbackCalled() {
        var finishedCalled = false
        flowHandler = FlowHandler(finished: { _, _ in
            finishedCalled = true
        })
        flowHandler.flowFinished(result: 0, dismisser: nil)
        XCTAssertTrue(finishedCalled)
    }

    func testFlowCreatedWithEmptyFinishWillDismissAnimatedDyDefault() {
        let dismisser = FakeViewControllerDismisser(onDismiss: {})
        flowHandler = FlowHandler()
        flowHandler.flowFinished(result: 0, dismisser: dismisser)
        XCTAssertTrue(dismisser.dismissCalled)
        XCTAssertEqual(dismisser.dismissAnimated, true)
    }
}
