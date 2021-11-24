//
//  CalculateBadge.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation
import UIKit

class CalculateBadge {
    
    static func countBadge(_ search: Filter) -> Int {
        if search.startDate == "" || search.endDate == "" {
            if search.startDate == "" && search.endDate == "" {
                return search.searchIn!.count
            } else if search.startDate == "" && search.endDate != ""{
                return search.searchIn!.count + 1
            } else {
                return search.searchIn!.count + 1
            }
        } else {
            return search.searchIn!.count + 2
        }
    }
}
