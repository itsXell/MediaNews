//
//  SearchInView.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class SearchInView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        addSubview(applyBtn)
        applyBtn.translatesAutoresizingMaskIntoConstraints = false
        applyBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        applyBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        applyBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        applyBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.applyBtn.topAnchor, constant: -10).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search In"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = true
        return table
    }()
    
    let applyBtn: UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.orange
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(SearchInController.applyFilter), for: .touchUpInside)
        return button
    }()
}
