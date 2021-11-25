//
//  SortByCell.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import UIKit

class SortByCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addSubview(selectIndicator)
        selectIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectIndicator.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -10).isActive = true
        selectIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        selectIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectIndicator.addSubview(innerIndicator)
        innerIndicator.translatesAutoresizingMaskIntoConstraints = false
        innerIndicator.centerYAnchor.constraint(equalTo: selectIndicator.centerYAnchor).isActive = true
        innerIndicator.centerXAnchor.constraint(equalTo: selectIndicator.centerXAnchor).isActive = true
        innerIndicator.widthAnchor.constraint(equalToConstant: 15).isActive = true
        innerIndicator.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let selectIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 15
        return view
    }()
    
    let innerIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 7.5
        return view
    }()

}
