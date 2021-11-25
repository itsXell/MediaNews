//
//  SortByController.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class SortByController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let mockUp = ["Upload date", "Relevance"]
    var selectedMockup = BehaviorRelay<String>(value: "Upload date")
    let cellID = "CellID"
    let bag = DisposeBag()
    let selectedValueSub = PublishSubject<String>()
    var selectedValue: Observable<String>{
        return selectedValueSub.asObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    private func setupUI() {
        let view = SortByView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SortByCell.self, forCellReuseIdentifier: cellID)
    }
}

extension SortByController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockUp.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SortByCell
        cell.titleLabel.text = mockUp[indexPath.row]
        cell.selectionStyle = .none
        selectedMockup.asDriver().drive(onNext: { selectedTxt in
            if self.mockUp[indexPath.row] == selectedTxt {
                cell.selectIndicator.rx.backgroundColor.onNext(UIColor.orange)
                cell.innerIndicator.rx.backgroundColor.onNext(UIColor.white)
            } else {
                cell.selectIndicator.rx.backgroundColor.onNext(UIColor.lightGray)
                cell.innerIndicator.rx.backgroundColor.onNext(UIColor.lightGray)
            }
        }).disposed(by: bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMockup.accept(mockUp[indexPath.row])
        if mockUp[indexPath.row] == "Upload date" {
            selectedValueSub.onNext("publishedAt")
        } else {
            selectedValueSub.onNext("relevance")
        }
    }
}
