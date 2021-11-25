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
        switch filter {
        case _ where filter.startDate != "":
            arrayBody.append("from=\(filter.startDate ?? "")")
            fallthrough
        case _ where filter.endDate != "":
            arrayBody.append("to=\(filter.endDate ?? "")")
            fallthrough
        case _ where filter.searchIn?.count != 0 :
            arrayBody.append("in=\(SearchInProducer.concatenatedArray(filter.searchIn!).lowercased().replacingOccurrences(of: " ", with: ""))")
        default:
            body = sortBy
        }
        body = concatenatedBody(arrayBody)
        return body
    }
    
    private func concatenatedBody(_ array: [String]) -> String {
        let concat = array.joined(separator: "&")
        return concat
    }
}
