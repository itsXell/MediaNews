//
//  String.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import Foundation
import UIKit

extension String {
    func concatenatedArray(array: [String]) -> String {
        if array.count == 3 {
             return "All"
        } else if array.count == 0  {
            return "None"
        } else {
            let concat = array.joined(separator: ", ")
            return concat
        }
    }
}
