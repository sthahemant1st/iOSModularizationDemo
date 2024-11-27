import UIKit

public extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setBorderToLeft() {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: 0.0, y: 0, width: 1.0, height: self.frame.size.height)
        //        leftBorder.backgroundColor = UIColor.from(hex: "E1E5F2").cgColor
        self.layer.addSublayer(leftBorder)
        
    }
    func addBorder() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
