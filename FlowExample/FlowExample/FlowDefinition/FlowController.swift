final class FlowController: FlowInspectable {

    private var activeFlow: AnyObject?
    private(set) var activeSubFlowResultType: Any.Type?

    func start<F: Flow, R>(flow: F,
                           onStarted: (() -> Void)? = nil,
                           onCompleted: ((R, ViewControllerDismisser?) -> Void)? = nil) where F.FlowResultType == R {
        activeFlow = flow
        activeSubFlowResultType = R.self
        flow.flowHandler = FlowHandler(
            started: {
            onStarted?()
        },
            finished: { [weak self] (result, dismisser) in
                self?.activeFlow = nil
                self?.activeSubFlowResultType = nil

                if let onCompleted = onCompleted {
                    onCompleted(result, dismisser)
                } else {
                    dismisser?.dismiss(animated: true, completion: nil)
                }

        })
        flow.start()
    }
}
