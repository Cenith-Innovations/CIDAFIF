// ********************** Date+Extensions *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** Date+Extensions *********************************


import Foundation

public extension Date {
    
    func dafifDisplayDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        if self == Date.init(timeIntervalSince1970: 0) {
            return "🗓"
        } else {
            return df.string(from: self) + "  🗓"
        }
    }
    
}

public extension Optional where Wrapped == Date {
    
    func dafifDisplayDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        guard let date = self else { return "🗓"}
        if self == Date.init(timeIntervalSince1970: 0) {
            return "🗓"
        } else {
            return df.string(from: date) + "  🗓"
        }
    }
    
}
