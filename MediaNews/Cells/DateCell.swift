//
//  DateCell.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class DateCell: UITableViewCell {

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
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        addSubview(dateTxtField!)
        dateTxtField!.translatesAutoresizingMaskIntoConstraints = false
        dateTxtField!.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        dateTxtField!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateTxtField!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dateTxtField!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        dateTxtField!.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    weak var dateTxtField: UITextField? = {
        let txtfield = UITextField()
        txtfield.placeholder = "yyyy/mm/dd"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtfield.frame.height - 1, width: txtfield.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.addSublayer(bottomLine)

        return txtfield
    }()
}
