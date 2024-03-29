// ********************** DateFormat *********************************
// * Copyright © Cenith Innovations, LLC - All Rights Reserved
// * Created on 1/13/21, for 
// * Matthew Elmore <matt@cenithinnovations.com>
// * Unauthorized copying of this file is strictly prohibited
// ********************** DateFormat *********************************


import Foundation

/// Usefule reference [Here](https://www.datetimeformatter.com/how-to-format-date-time-in-swift/)
public enum DateFormat {
    case dafifCycle
    case dafifSpecification
    case dafifCurrency
    case milKeep
    case logTenPro
    case pirep
    case MMM_dd
    case MMM_dd_YYYY
    case ReserveCentsStandard
    case metarAndTaf
    case tafStartEnd
    case ahas
    case reference
    case aws
    case swiftStandard
    case stringDisplay
    case notamCreated
    case notam
    case dateOfEntry
    case fbcCalendar
    case rcSupportEmailID
    case other(String)

    public var value: String {
        switch self {
            case .dafifCycle: return "yyyy"
            case .dafifSpecification: return "MMyyyy"
            case .dafifCurrency: return "ddMMyyyy"
            case .milKeep: return "ddMMMyy"
            case .logTenPro: return "YYYY-MM-dd"
            case .pirep: return "ddMMYY'-'HH:mm'GMT"
            case .MMM_dd: return "MMM dd"
            case .MMM_dd_YYYY: return "MMM dd YYYY"
            case .ReserveCentsStandard: return "MMM dd, YYYY"
            case .metarAndTaf: return "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
            case .tafStartEnd: return "yyyy'-'MM'-'dd' 'HH':'mm':'ss' +'Z"
            case .ahas: return "yyyy'-'MM'-'dd' 'HH':'mm':'ss.sss"
            case .reference: return "yyyyMMddHHmmss"
            case .aws: return "yyyy'-'MM'-'dd'T'HH':'mm':'sssss'Z'"
            case .swiftStandard: return "yyyy'-'MM'-'dd' 'HH':'mm':'ss' 'Z'"
            case .stringDisplay: return "MMM d, hh:mm"
            case .notamCreated: return "dd MMM HH:mm yyyy"
            case .notam: return "ddMMMHH:mmyyyy" //16JUL07:392019
            case .dateOfEntry: return "MMM dd, yyyy"
            case .fbcCalendar: return "mm DDD yyyy"
            case .rcSupportEmailID: return "ssmmyyddhh"
            case .other(let val): return val
        }
    }
}
