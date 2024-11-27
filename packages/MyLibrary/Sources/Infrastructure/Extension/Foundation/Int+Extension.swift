import Foundation

public extension Int {
    var stringValue: String { String(self) }
    
    var doubleValue: Double { Double(self) }
}
public extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? 0
    }
}
