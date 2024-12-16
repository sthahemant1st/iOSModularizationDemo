import Foundation

public extension Double {
    
    var stringValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func roundedString(_ places: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = places
        return numberFormatter.string(from: NSNumber(value: self)) ?? "--"
    }
    
    var removeZero: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self))
        // return nf.stringFromNumber(self)!
    }
}
public extension Optional where Wrapped == Double {
    var orZero: Double {
        self ?? 0.0
    }
}
