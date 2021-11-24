//
//  FilterHeaderView.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class FilterHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerStackView.addArrangedSubview(FilterTitle)
        headerStackView.addArrangedSubview(DateTitle)
    }
    
    let FilterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Filter"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let DateTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Date"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .white
        return stackView
    }()
}
