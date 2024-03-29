//
//  SearchInController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class SearchInController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mockup = ["Title", "Description", "Content"]
    let selectedValueSub = PublishSubject<[String]>()
    var selectedValue: Observable<[String]>{
        return selectedValueSub.asObserver()
    }
    let bag = DisposeBag()
    var selectedArray = BehaviorRelay<[String]>(value: [])

    var tableView = UITableView()
    let cellID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "SearchIn View"
        setupUI()
        registerTableView()
        setupNavItems()
    }
    
    private func setupUI() {
        let view = SearchInView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchInCell.self, forCellReuseIdentifier: cellID)
    }
    
    @IBAction func applyFilter() {
        selectedValueSub.onNext(selectedArray.value)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleClear(_ sender: Any?) {
        selectedArray.accept([])
    }
    
    private func setupNavItems() {
        let clearBtn = UIButton(type: .system)
        clearBtn.setImage(UIImage.init(systemName: "trash")!.withRenderingMode(.alwaysOriginal), for: .normal)
        clearBtn.contentHorizontalAlignment = .center
        clearBtn.contentVerticalAlignment = .center
        clearBtn.addTarget(self, action: #selector(handleClear(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearBtn)
    }
}

extension SearchInController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchInCell
        cell.selectionStyle = .none
        cell.titleLabel.text = mockup[indexPath.row]
        self.selectedArray.bind(onNext: { value in
            if value.contains(self.mockup[indexPath.row]) {
                cell.onOffSwitch.isOn = true
            } else {
                cell.onOffSwitch.isOn = false
            }
        }).disposed(by: bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedArray.value.contains(mockup[indexPath.row]) {
            let value = selectedArray.value
            let newValue = value.filter({$0 != mockup[indexPath.row]})
            selectedArray.accept(newValue)
        } else {
            var value = selectedArray.value
            value.append(mockup[indexPath.row])
            selectedArray.accept(value)
        }
    }
}
