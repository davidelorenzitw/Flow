struct EmptyViewControllerDismisser: ViewControllerDismisser {

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}
