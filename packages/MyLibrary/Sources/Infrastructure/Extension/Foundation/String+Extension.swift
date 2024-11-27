import Foundation

public extension String {
//    var localized: String {
//        return NSLocalizedString(self, comment: self)
//    }
//    func localize(_ arguments: CVarArg...) -> String {
//        String(format: NSLocalizedString(self, bundle: .localizedBundle!, comment: self), arguments)
//    }
//    var localized: String {
//        return NSLocalizedString(self, tableName: nil, bundle: .localizedBundle!, value: self, comment: self)
//    }
    var localized: String {
        self
    }
    func abbreviatedName() -> String {
        // Split the string into individual words
        let nameComponents = self.split(separator: " ")
        
        // Ensure there are at least two components (first name and last name)
        guard let firstName = nameComponents.first, let lastName = nameComponents.last else { return "" }
        
        // Return the abbreviation using the first letter of the first and last name
        let abbreviation = "\(firstName.prefix(1))\(lastName.prefix(1))".uppercased()
        return abbreviation
    }
    /// Returns String unicode value of country flag for iso code
    func getFlag() -> String {
        unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    func urlQueryEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    var nilIfEmpty: String? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
    var isNotEmpty: Bool {
        !isEmpty
    }
}

// MARK: Conversion
public extension String {
    var toDouble: Double? {
        return Double(self)
    }
    var doubleValue: Double {
        return Double(self).orZero
    }
    var intValue: Int {
        return Int(self).orZero
    }
}

// MARK: optional
public extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
    var orDash: String {
        self ?? "-"
    }
    
    var nilOrEmpty: Bool {
        self.isNil || self?.isEmpty == true
    }
    
    var notNilOrEmpty: Bool {
        !self.nilOrEmpty
    }
}
