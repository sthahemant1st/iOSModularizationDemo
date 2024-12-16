import Foundation

public extension URL {
    var sizePerMB: Double {
        do {
            let attribute = try FileManager.default.attributesOfItem(atPath: self.path)
            if let size = attribute[FileAttributeKey.size] as? NSNumber {
                return size.doubleValue / 1000000.0
            }
        } catch {
//            printInDebugOnly("Error: \(error)")
        }
        return 0.0
    }
}
