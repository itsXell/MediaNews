//
//  TextField.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import Foundation
import UIKit

extension UITextField{
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .done, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: true)
        self.inputAccessoryView = toolBar
    }
}
