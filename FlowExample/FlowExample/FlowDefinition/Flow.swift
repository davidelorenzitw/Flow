protocol Flow: class {
    associatedtype FlowResultType

    var flowHandler: FlowHandler<FlowResultType> { get set }
    var flowInspectable: FlowInspectable { get }
    func start()
    func terminate()
}

struct FlowHandler<T> {

    private let onStarted: (() -> Void)?
    private let onFinished: ((T, ViewControllerDismisser?) -> Void)?

    init(started: (() -> Void)? = nil,
         finished: ((T, ViewControllerDismisser?) -> Void)? = nil) {
        onStarted = started
        if let finished = finished {
            onFinished = finished
        } else {
            onFinished = { _, dismisser in
                dismisser?.dismiss(animated: true, completion: nil)
            }
        }
    }

    func flowStarted() {
        onStarted?()
    }

    func flowFinished(result: T,
                      dismisser: ViewControllerDismisser?) {
        onFinished?(result, dismisser)
    }
}
