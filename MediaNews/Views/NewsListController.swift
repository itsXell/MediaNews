//
//  NewsListController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class NewsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    var tableView = UITableView()
    let tableCellID = "Cell"
    
    let news: [Article] = [Article(title: "Spiderman", description: "New Trailer", content: "It just break the record", url: ""),Article(title: "Ironman dead", description: "The fade of Iron Man", content: "Iron die in end game", url: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        registerTableViewCell()
    }
    
    private func initialView() {
        let view = NewsListView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableViewCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: tableCellID)
    }
    


}

extension NewsListController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! NewsCell
        cell.titleLabel.text = news[indexPath.row].title
        cell.descriptionLabel.text = news[indexPath.row].title
        return cell
    }
}
