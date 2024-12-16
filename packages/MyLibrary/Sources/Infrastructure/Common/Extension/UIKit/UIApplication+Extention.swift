import UIKit

public extension UIApplication {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            self.open(url, options: [:], completionHandler: { _ in })
        }
    }
        
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
    var firstKeyWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}
