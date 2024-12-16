import Foundation

public extension Numeric {
    
    func formatCurrency(_ currency: String, maxFractionDigit: Int = 2) -> String {
        let formatter = NumberFormatter()
        
        formatter.maximumFractionDigits = maxFractionDigit
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencyCode = currency

        if currency == "" {
            formatter.currencySymbol = ""
        }
        if currency == "KRW" {
            formatter.currencySymbol = "KRW"
        }
        formatter.usesGroupingSeparator = true
        
        return formatter.string(for: self) ?? "--"
    }
}
