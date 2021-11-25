//
//  NewsListView.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class NewsListView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addSubview(friendlyLabel)
        friendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        friendlyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        friendlyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.allowsSelection = true
        return table
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .orange
        return spinner
    }()
    
    let friendlyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.isHidden = true
        label.textColor = .black
        label.text = "Fail to Retrieve Data 😢"
        return label
    }()
}
