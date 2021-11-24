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
    var searchInResult = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        showDatePicker()
        addFooterStackAction()
        setupNavItems()
    }
    
    private func setupView() {
        let view = FilterView(frame: self.view.frame)
        self.fromTxtField = view.fromDateTxtField
        self.endTxtField = view.endDateTxtfield
        self.footerStack = view.footerStackview
        self.searchInResult = view.searchInResult
        self.view = view
    }
    
    private func addFooterStackAction() {
        footerStack.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(stackviewTapped))
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
    
    @objc func stackviewTapped() {
        let nextVc = SearchInController()
        navigationController?.pushViewController(nextVc, animated: true)
        nextVc.selectedValue.asObservable().subscribe(onNext: { [weak self] searches in
            if searches.count == 3 {
                self?.searchInResult.text = "All"
            } else {
                let concat = searches.joined(separator: ", ")
                self?.searchInResult.text = concat
            }
        })
    }
    
    @IBAction func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true) {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupNavItems() {
        let dismissButton = UIButton(type: .system)
        dismissButton.setImage(UIImage.init(systemName: "xmark")!.withRenderingMode(.alwaysOriginal), for: .normal)
        dismissButton.contentHorizontalAlignment = .center
        dismissButton.contentVerticalAlignment = .center
        dismissButton.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        let clearBtn = UIButton(type: .system)
        clearBtn.setImage(UIImage.init(systemName: "trash")!.withRenderingMode(.alwaysOriginal), for: .normal)
        clearBtn.contentHorizontalAlignment = .center
        clearBtn.contentVerticalAlignment = .center
        clearBtn.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearBtn)
    }
    
}
