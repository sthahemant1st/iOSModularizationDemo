import Foundation

extension Calendar {
    func numberOfDaysBetween(_ fromDate: Date, and toDate: Date = .init()) -> Int {
        let fromDate = startOfDay(for: toDate)
        let toDate = startOfDay(for: fromDate)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}
