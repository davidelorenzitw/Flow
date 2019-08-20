@testable import FlowExample
import UIKit

final class FakeViewControllerDismisser: ViewControllerDismisser {

    var dismissCalled = false
    var dismissAnimated: Bool?
    private let dismissAction: () -> Void

    init(onDismiss: @escaping () -> Void) {
        dismissAction = onDismiss
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismissCalled = true
        dismissAnimated = animated
        dismissAction()
        completion?()
    }
}

extension Array where Element: UIViewController {
    func keepOnlyBefore(viewController: UIViewController) -> [UIViewController] {
        guard let position = firstIndex(where: { $0 == viewController }) else {
            return self
        }
        let itemsToDrop = count - position
        return Array(dropLast(itemsToDrop))
    }
}
