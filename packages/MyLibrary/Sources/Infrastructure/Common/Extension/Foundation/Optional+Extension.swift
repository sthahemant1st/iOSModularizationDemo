import Foundation

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var hasValue: Bool {
        return !isNil
    }
}
