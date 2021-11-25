//
//  DateConverter.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation

class DateConverter {
    
    static func DateConverter(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        return date
    }
}
