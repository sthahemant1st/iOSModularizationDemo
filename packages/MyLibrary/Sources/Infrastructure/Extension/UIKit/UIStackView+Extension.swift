import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ subViews: UIView...) {
        subViews.forEach(addArrangedSubview(_:))
    }
}
