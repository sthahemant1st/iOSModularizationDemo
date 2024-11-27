import Foundation

public extension Bool {
    var stringValue: String {
        return String(self)
    }
}

public extension Optional where Wrapped == Bool {
    var orFalse: Bool {
        self ?? false
    }
}
