import Foundation

public extension Date {
    static func getDate(
        from stringDate: String,
        having format: String
    ) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: stringDate)
    }

    func formattedDate(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
    
    static func getDateTimeString(
        fromDate stringDate: String,
        withFormat: String,
        toFormat: String
    ) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = withFormat
        guard let date = formatter.date(from: stringDate) else { return nil }
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }

}
