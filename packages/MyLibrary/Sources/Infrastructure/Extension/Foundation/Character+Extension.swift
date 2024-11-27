import Foundation

public extension Character {
    var isEnglishLetter: Bool {
        ("a"..."z").contains(self) || ("A"..."Z").contains(self)
    }
    
    var isEnglishLetterOrSpace: Bool {
        isEnglishLetter || isWhitespace
    }
    
    var isEnglishNumber: Bool {
        ("0"..."9").contains(self)
    }
    
    var isEnglishLetterOrNumber: Bool {
        isEnglishLetter || isEnglishNumber
    }
    
    var isEnglishLetterOrNumberOrSpace: Bool {
        isEnglishLetter || isEnglishNumber || isWhitespace
    }
}
