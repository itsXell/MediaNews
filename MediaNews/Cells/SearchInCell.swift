//
//  SearchInCell.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class SearchInCell: UITableViewCell {

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
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        addSubview(onOffSwitch)
        onOffSwitch.translatesAutoresizingMaskIntoConstraints = false
        onOffSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        onOffSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Search  in"
        return label
    }()
    
    let onOffSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.onTintColor = .orange
        repeatSwitch.tintColor = .orange
        return repeatSwitch
    }()

}
