//
//  SearchInController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class SearchInController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mockup = ["Title", "Description", "Content"]
    
    var tableView = UITableView()
    let cellID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        registerTableView()
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
    
    


}

extension SearchInController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchInCell
        cell.titleLabel.text = mockup[indexPath.row]
        return cell
    }
}
