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
        addSubview(bodyStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        headerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
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
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let fromDateTxtField: UITextField? = {
        let txtfield = UITextField()
        txtfield.placeholder = "yyyy/mm/dd"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtfield.frame.height - 1, width: txtfield.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.addSublayer(bottomLine)

        return txtfield
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    weak var endDateTxtfield: UITextField? = {
        let txtfield = UITextField()
        txtfield.placeholder = "yyyy/mm/dd"
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtfield.frame.height - 1, width: txtfield.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.addSublayer(bottomLine)

        return txtfield
    }()
    
    let bodyStackView: UIStackView = {
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
