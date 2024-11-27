import Foundation

public extension Array where Element: Equatable {
    /// return unique element array maintaining the order
    /// eg: [1, 2, 3, 4, 5, 2, 1, 5, 3, 7, 6] returns -> [1, 2, 3, 4, 5, 7, 6]
    func uniqued() -> Array {
        var buffer = Array()
        for element in self where !buffer.contains(where: { $0 == element }) {
            buffer.append(element)
        }
        return buffer
    }
}

public extension Array {
    /// returns Element at index or defaultE if index out of bound
    /// prevents index out of bound while getting itemAtIndex
    func getAt(_ index: Int, defaultE: Element? = nil) -> Element? {
        if index >= self.count {
            return defaultE
        }
        return self[index]
    }
}
