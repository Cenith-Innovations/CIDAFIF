// ********************** String+Extensions *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** String+Extensions *********************************


import Foundation

public extension String {
    
    var errorNumber: Double { 9999 }
    
    var toDouble: Double { Double(self) ?? errorNumber }
    
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
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
