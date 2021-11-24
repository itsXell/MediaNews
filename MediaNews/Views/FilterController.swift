//
//  FilterController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class FilterController: UIViewController {

    var tableView = UITableView()
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var fromTxtField = UITextField()
    var endTxtField = UITextField()
    var footerStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        showDatePicker()
        addFooterStackAction()
    }
    
    private func setupView() {
        let view = FilterView(frame: self.view.frame)
        self.fromTxtField = view.fromDateTxtField
        self.endTxtField = view.endDateTxtfield
        self.footerStack = view.footerStackview
        self.view = view
    }
    
    private func addFooterStackAction() {
        footerStack.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(click))
        footerStack.addGestureRecognizer(tap)
    }

    func showDatePicker() {
        self.fromTxtField.setInputViewDatePicker(target: self, selector: #selector(doneTappedFrom))
        self.endTxtField.setInputViewDatePicker(target: self, selector: #selector(doneTappedEnd))
    }
    
    @objc func doneTappedFrom() {
        if let datePicker = self.fromTxtField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.fromTxtField.text = dateFormatter.string(from: datePicker.date)
        }
        self.fromTxtField.resignFirstResponder()
    }
    
    @objc func doneTappedEnd() {
        if let datePicker = self.endTxtField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.endTxtField.text = dateFormatter.string(from: datePicker.date)
        }
        self.endTxtField.resignFirstResponder()
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
            
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
        }
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func click() {
        print("Hello")
    }
    
}

extension FilterController {
    
   
    
}
