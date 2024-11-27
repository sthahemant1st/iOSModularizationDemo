import UIKit

public extension UIViewController {
    static var stringIdentifier: String {
        return String(describing: self)
    }
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}

// MARK: Alerts
public extension UIViewController {
    func showLogoutAlert(onYesTapped: @escaping () -> Void) {
        showAlert(
            alertTitle: "Logout!",
            withMessage: "Are you sure you want to Logout?",
            okTitle: "Yes",
            okHandler: onYesTapped,
            cancelTitle: "Cancel"
        )
    }
    
    func showPermissionAlert(
        title: String,
        message: String,
        cancelHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .default,
                handler: cancelHandler
            )
        )
        alertController.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            UIApplication.shared.openSettings()
        })
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func showAlert(alertTitle: String = UIApplication.appName ?? "",
                   withMessage message: String,
                   okTitle: String = "Yes",
                   okHandler: @escaping () -> Void = {},
                   cancelTitle: String = "Cancel",
                   cancelHandler: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            okHandler()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            cancelHandler()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithOk(alertTitle: String = UIApplication.appName ?? "",
                         withMessage message: String,
                         okTitle: String = "OK",
                         okAction: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            okAction()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertSheetWithTwoAction(
        alertTitle: String = UIApplication.appName ?? "",
        alertMessage: String? = nil,
        firstActionTitle: String = "OK",
        onFirstAction: @escaping (UIAlertAction) -> Void = { _ in},
        secondActionTitle: String = "OK",
        secondActionStyle: UIAlertAction.Style = .destructive,
        onsecondAciton: @escaping (UIAlertAction) -> Void = {_ in},
        sourceRect: CGRect,
        sourceView: UIView
    ) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(
            title: firstActionTitle,
            style: .default,
            handler: onFirstAction
        )
        let secondAction = UIAlertAction(
            title: secondActionTitle,
            style: secondActionStyle,
            handler: onsecondAciton
        )
        let cancelAction = UIAlertAction(
            title: "Cancel".localized,
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceRect = sourceRect
            popoverPresentationController.sourceView = sourceView
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertSheetWithThreeAction(
        alertTitle: String = UIApplication.appName ?? "",
        firstActionTitle: String = "OK".localized,
        onFirstAction: @escaping () -> Void = {},
        secondActionTitle: String = "OK".localized,
        onsecondAction: @escaping () -> Void = {},
        thirdActionTitle: String = "OK".localized,
        thirdActionStyle: UIAlertAction.Style = .destructive,
        onThirdAction: @escaping () -> Void = {}
    ) {
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstActionTitle, style: .default, handler: { (_) in
            onFirstAction()
        })
        let secondAction = UIAlertAction(title: secondActionTitle, style: .default, handler: { (_) in
            onsecondAction()
        })
        let thirdAction = UIAlertAction(title: thirdActionTitle, style: thirdActionStyle, handler: { (_) in
            onThirdAction()
        })
        let cancelAction = UIAlertAction(
            title: "Cancel".localized,
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(thirdAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertSheetWithSingleAction(
        alertTitle: String = UIApplication.appName ?? "",
        firstActionTitle: String = "Add",
        onFirstAction: @escaping () -> Void = {}
    ) {
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: firstActionTitle, style: .default, handler: { (_) in
            onFirstAction()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(firstAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    func openUrlString(_ string: String) {
        if let url = URL(string: string),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func callNumber(_ number: String) {
        guard let url = URL(string: "tel://\(number)")  else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
