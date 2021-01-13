// ********************** String+Extensions *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** String+Extensions *********************************


import Foundation

public extension String {
    
    var toDecimal: NSDecimalNumber { NSDecimalNumber(string: self) }
    
    var errorNumber: Double { 9999 }
    
    var toDouble: Double { Double(self) ?? errorNumber }
    
    var toInt16: Int16 { Int16(self.description) ?? Int16(errorNumber) }
    
    func removeAllCharOf(_ str: String) -> String {
        let charR = Character(str)
        var returnCharecters: [Character] = []
        for char in self {
            if char != charR {
                returnCharecters.append(char)
            }}
        return String(returnCharecters)
    }
    
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    
    func subStringFrom(_ from: Int, offsetBy: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(startIndex, offsetBy: offsetBy)
        return String(self[startIndex...endIndex])
    }
    
    ///This translates Dates from various API's into Date()
    func getDateFrom(ofType: DateFormat) -> Date? {
        let df = DateFormatter()
        df.dateFormat = ofType.value
        df.timeZone = TimeZone(abbreviation: "UTC")
        switch ofType {
        case .reference:
            let refDate = "19700101000000"
            return df.date(from: refDate)
        default:
            return df.date(from: self)
    }}
    
    ///This translates Dates from various API's into Date()
    func getDateFrom(str: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = str
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df.date(from: self)
    }
    
    var getPhoneNumber: String? {
        let pattern = "[0-9]{3}-[0-9]{3}-[0-9]{4}"
        if let range = self.range(of: pattern, options: .regularExpression) {
            return String(self[range])
        } else {
            return nil
        }
    }
    
    func replaceFirst(_ number: Int, with: String) -> String {
        let range = self.index(self.startIndex, offsetBy: number)
        return self.replacingCharacters(in: self.startIndex..<range, with: with)
    }
    
    func indices(of: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: of, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = of.distance(from: of.startIndex,
                                             to: of.endIndex) - 1
            guard let after = index(range.lowerBound,
                                    offsetBy: offset,
                                    limitedBy: endIndex) else {
                                        break
            }
            position = index(after: after)
        }
        return indices
    }
    
    func ranges(of: String) -> [Range<String.Index>] {
        let _indices = indices(of: of)
        let count = of.count
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0+count) })
    }
    
    
    func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func lowerCaseFirstLetter() -> String {
        return self.prefix(1).lowercased() + dropFirst()
    }
    
}
