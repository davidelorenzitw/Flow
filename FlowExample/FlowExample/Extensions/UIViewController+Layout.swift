import UIKit

extension UIViewController {
    func pinToEdges(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        NSLayoutConstraint.activate(constraints)
    }
}
