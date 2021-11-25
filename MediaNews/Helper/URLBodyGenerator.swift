//
//  URLBodyGenerator.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation

class URLBodyGenerator {
    
    func urlBodyGenerator(filter: Filter, sortBy: String) -> String {
        var body = ""
        var arrayBody: [String] = ["sortby=\(sortBy)"]
        if filter.startDate != "" {
            let startDate = DateConverter.ConvertToUTCString(dateString: filter.startDate!)
            arrayBody.append("from=\(startDate)")
        }
        if filter.endDate != "" {
            let endDate = DateConverter.ConvertToUTCString(dateString: filter.endDate!)
            arrayBody.append("to=\(endDate)")
        }
        if filter.searchIn?.count != 0 {
            arrayBody.append("in=\(SearchInProducer.concatenatedArray(filter.searchIn!).lowercased().replacingOccurrences(of: " ", with: ""))")
        }
        body = concatenatedBody(arrayBody)
        return body
    }
    
    private func concatenatedBody(_ array: [String]) -> String {
        let concat = array.joined(separator: "&")
        return concat
    }
}

