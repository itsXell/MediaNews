//
//  FilterController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class FilterController: UIViewController {

    var tableView = UITableView()
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var fromTxtField = UITextField()
    var endTxtField = UITextField()
    var footerStack = UIStackView()
    var searchInResult = UILabel()
    
    let bag = DisposeBag()
    let searchSubject = PublishSubject<Filter>()
    var searchValue: Observable<Filter>{
        return searchSubject.asObservable()
    }
    var startDateString = BehaviorRelay<String>(value: "")
    var endDateString = BehaviorRelay<String>(value: "")
    var searchInRelay = BehaviorRelay<[String]>(value: [])
    var searchRelay = BehaviorRelay<Filter>(value: Filter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        initialCreatedValue()
        showDatePicker()
        addFooterStackAction()
        setupNavItems()
        bindUIView()
    }
    
    /*Begin Setup User Interface*/
    
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
    
    private func initialCreatedValue() {
        startDateString.accept(searchRelay
                                .value.startDate!)
        endDateString.accept(searchRelay.value.endDate!)
        searchInRelay.accept(searchRelay.value.searchIn!)
    }
    
    private func bindUIView(){
        startDateString.bind(onNext: { date in
            self.fromTxtField.rx.text.onNext(date)
        }).disposed(by: bag)
        endDateString.bind(onNext: { date in
            self.endTxtField.rx.text.onNext(date)
        }).disposed(by: bag)
        self.searchInRelay.bind(onNext: { searches in
            self.searchInResult.rx.text.onNext(SearchInProducer.concatenatedArray(searches))
        }).disposed(by: bag)
    }
    
    /* End Setup User Interface*/
    
    /* Begin implement of Date Picker Controller*/

    func showDatePicker() {
        self.fromTxtField.setInputViewDatePicker(target: self, selector: #selector(doneTappedFrom))
        self.endTxtField.setInputViewDatePicker(target: self, selector: #selector(doneTappedEnd))
    }
    
    @objc func doneTappedFrom() {
        if let datePicker = self.fromTxtField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePicker.date)
            startDateString.accept(dateString)
        }
        self.fromTxtField.resignFirstResponder()
    }
    
    @objc func doneTappedEnd() {
        if let datePicker = self.endTxtField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePicker.date)
            endDateString.accept(dateString)
        }
        self.endTxtField.resignFirstResponder()
    }
    
    /* End implement of Date Picker Controller*/
    
    /* Begin implement Navigation Setup and action*/

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
        clearBtn.addTarget(self, action: #selector(handleClear(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearBtn)
    }
    
    @objc func handleDismiss(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleClear(_ sender: Any?) {
        endDateString.accept("")
        startDateString.accept("")
        searchInRelay.accept([])
        searchRelay.accept(Filter(startDate: "", endDate: "", searchIn: []))
    }
    
    /* Begin implement Navigation Setup and action*/
    
    /*Button Action*/
    
    @objc func stackviewTapped() {
        let nextVc = SearchInController()
        nextVc.selectedArray.accept(searchInRelay.value)
        navigationController?.pushViewController(nextVc, animated: true)
        nextVc.selectedValue.asObservable().subscribe(onNext: { [weak self] searches in
            self?.searchInRelay.accept(searches)
        }).disposed(by: bag)
    }
    
    @objc func handleApply() {
        if startDateString.value != "" && endDateString.value != "" {
            let startDate = DateConverter.DateConverter(dateString: startDateString.value)
            let endDate = DateConverter.DateConverter(dateString: endDateString.value)
            if endDate < startDate {
                AlertHelper.showAlert(title: "Wrong Input", alert: "End date must be greater than start date", controller: self)
            } else {
                self.dismiss(animated: true, completion: {
                    let currentSearch = Filter(startDate: self.startDateString.value, endDate: self.endDateString.value, searchIn: self.searchInRelay.value)
                    self.searchRelay.accept(currentSearch)
                })
            }
        } else {
            self.dismiss(animated: true, completion: {
                let currentSearch = Filter(startDate: self.startDateString.value, endDate: self.endDateString.value, searchIn: self.searchInRelay.value)
                self.searchRelay.accept(currentSearch)
            })
        }
    }
}
