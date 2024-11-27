import Foundation

public extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
    
    func toJSONString() -> String? {
        if let jsonData = jsonData {
            return String(decoding: jsonData, as: UTF8.self)
        }
        
        return nil
    }
}
