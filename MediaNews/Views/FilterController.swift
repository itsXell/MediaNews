//
//  FilterController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class FilterController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView = UITableView()
    let cellID = "Cell"
    let searchCellID = "SearchCellID"
    let headerID = "HeaderCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerTableView()
    }
    
    private func setupView() {
        let view = FilterView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DateCell.self, forCellReuseIdentifier: cellID)
        tableView.register(SearchInCell.self, forCellReuseIdentifier: searchCellID)
        tableView.register(FilterHeaderView.self, forHeaderFooterViewReuseIdentifier: headerID)
    }
    
}

extension FilterController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! FilterHeaderView
        header.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DateCell
            cell.titleLabel.text = "From"
            return cell
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: searchCellID, for: indexPath) as! SearchInCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }
    }
    
}
