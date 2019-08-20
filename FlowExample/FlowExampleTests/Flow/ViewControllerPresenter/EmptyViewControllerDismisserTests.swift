@testable import FlowExample
import XCTest

class EmptyViewControllerDismisserTests: XCTestCase {

    private let dismisser = EmptyViewControllerDismisser()

    func testDismiss() {
        var completionCalled = false
        dismisser.dismiss(animated: false,
                          completion: {
                              completionCalled = true
        })
        XCTAssertTrue(completionCalled)
    }
}
