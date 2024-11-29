import UIKit

public extension UIView {
    func roundCorners(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.layer.frame.size.height/2
        self.clipsToBounds = true
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func setBorder(borderWidth: CGFloat = 1.0,
                   borderColor: UIColor,
                   shouldCorner: Bool = true,
                   cornerRadius: CGFloat? = 12) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

        if shouldCorner {
            self.layer.cornerRadius = cornerRadius ?? self.layer.frame.size.height/2
            self.clipsToBounds = true
        }
    }
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: formate,
            options: NSLayoutConstraint.FormatOptions(),
            metrics: nil,
            views: viewsDictionary
        )
        addConstraints(constraints)
    }
}

public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
public extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    func addSeparator() {
        let separatorHeight: CGFloat = 1
        let frame = CGRect(x: 0, y: bounds.height - separatorHeight, width: bounds.width, height: separatorHeight)
        let separator = UIView(frame: frame)
//        separator.backgroundColor = UIColor.init(rgb: 0x737B89).withAlphaComponent(0.66)
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        addSubview(separator)
    }
}
public extension UIView {
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadowWithCornerRadius(color: UIColor, opacity: Float = 0.5, offSet: CGSize = .zero, shadowRadius: CGFloat = 4, scale: Bool = true, cornerRadius: CGFloat) {

        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }

    func addShadow(color: UIColor = .systemGray3, shadowRadius: CGFloat = 3, cornorRadius: CGFloat = 0) {
        layer.masksToBounds = false

        layer.cornerRadius = cornorRadius
        layer.shadowOpacity = 1
        layer.shadowColor = color.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius

        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1

    }

    func addTopShadow() {
        layer.shadowPath = CGPath(
            rect: CGRect(x: self.bounds.origin.x,
                         y: self.bounds.origin.y,
                         width: self.bounds.width,
                         height: 3),
            transform: .none
        )
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.systemGray3.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2

    }
}
public extension UIView {
    func setGradient(colors: [CGColor], angle: Float = 0) {
        let gradientLayerView: UIView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: bounds.width,
                                                             height: bounds.height))
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = gradientLayerView.bounds
        gradient.colors = colors
        let alpha: Float = angle / 360
        let startPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.75) / 2)),
            2
        )
        let startPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0) / 2)),
            2
        )
        let endPointX = powf(
            sinf(2 * Float.pi * ((alpha + 0.25) / 2)),
            2
        )
        let endPointY = powf(
            sinf(2 * Float.pi * ((alpha + 0.5) / 2)),
            2
        )
        gradient.endPoint = CGPoint(x: CGFloat(endPointX), y: CGFloat(endPointY))
        gradient.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        gradientLayerView.layer.insertSublayer(gradient, at: 0)
        layer.insertSublayer(gradientLayerView.layer, at: 0)
    }
}

public extension UIView {
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.9
        self.insertSubview(container, at: 1)
    }
}

public extension UIView {
    
    func fillToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    // src : https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
    fileprivate struct AssociatedObjectKeys {
        static let tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    func addRoundedCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    class var stringIdentifier: String {
        return String(describing: self)
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func showMessageLabel(embeddedLabel: UILabel, message: String, textColor: UIColor = UIColor.darkGray.withAlphaComponent(0.8)) {
        
        self.backgroundColor = UIColor.white
        
        embeddedLabel.text = message
        embeddedLabel.numberOfLines = 0
        embeddedLabel.translatesAutoresizingMaskIntoConstraints = false
        embeddedLabel.textAlignment = .center
        embeddedLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        embeddedLabel.textColor = textColor
        
        self.addSubview(embeddedLabel)
        
        NSLayoutConstraint(item: embeddedLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: embeddedLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: embeddedLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: embeddedLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        self.bringSubviewToFront(embeddedLabel)
    }
    
    func hideMessageLabel(embeddedLabel: UILabel?) {
        embeddedLabel?.removeFromSuperview()
    }
    
    // Embedded Activity Indicator
    
    func showLoadingIndicator(activityIndicator: UIActivityIndicatorView) {
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        activityIndicator.startAnimating()
        self.bringSubviewToFront(activityIndicator)
    }
    
    func hideLoadingIndicator(activityIndicator: UIActivityIndicatorView?) {
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    
}
