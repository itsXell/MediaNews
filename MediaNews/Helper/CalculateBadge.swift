//
//  CalculateBadge.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation
import UIKit
import RxCocoa

class CalculateBadge {
    
    static func countBadge(_ search: BehaviorRelay<Filter>) -> Int {
        if search.value.startDate == "" || search.value.endDate == "" {
            if search.value.startDate == "" && search.value.endDate == "" {
                return search.value.searchIn!.count
            } else if search.value.startDate == "" && search.value.endDate != ""{
                return search.value.searchIn!.count + 1
            } else {
                return search.value.searchIn!.count + 1
            }
        } else {
            return search.value.searchIn!.count + 2
        }
    }
}
