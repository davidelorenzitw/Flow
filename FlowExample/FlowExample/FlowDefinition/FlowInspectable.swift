protocol FlowInspectable {
    var activeSubFlowResultType: Any.Type? { get }
}

struct EmptyFlowInspectable: FlowInspectable {
    let activeSubFlowResultType: Any.Type? = nil
}
