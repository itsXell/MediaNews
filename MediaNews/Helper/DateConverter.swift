//
//  DateConverter.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation
import UIKit

class DateConverter {
    
    static func DateConverter(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        return date
    }
    
    static func ConvertToUTCString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        let utcDateFormat = DateFormatter()
        utcDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let utcString = utcDateFormat.string(from: date)
        return utcString
    }
}
