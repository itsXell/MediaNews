//
//  FilterView.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class FilterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerStackView.addArrangedSubview(FilterTitle)
        headerStackView.addArrangedSubview(DateTitle)
        addSubview(bodyStackView)
        bodyStackView.translatesAutoresizingMaskIntoConstraints = false
        bodyStackView.topAnchor.constraint(equalTo: self.headerStackView.bottomAnchor).isActive = true
        bodyStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bodyStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bodyStackView.heightAnchor.constraint(equalToConstant: self.bounds.height / 5).isActive = true
        bodyStackView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        bodyStackView.addArrangedSubview(fromLabel)
        bodyStackView.addArrangedSubview(fromDateTxtField)
        bodyStackView.addArrangedSubview(endLabel)
        bodyStackView.addArrangedSubview(endDateTxtfield)
        addSubview(footerStackview)
        footerStackview.translatesAutoresizingMaskIntoConstraints = false
        footerStackview.topAnchor.constraint(equalTo: self.bodyStackView.bottomAnchor, constant: 20).isActive = true
        footerStackview.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        footerStackview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        footerStackview.heightAnchor.constraint(equalToConstant: self.bounds.height / 10).isActive = true
        footerStackview.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        footerStackview.addArrangedSubview(searchInTitle)
        footerStackview.addArrangedSubview(searchInResult)
        addSubview(applyBtn)
        applyBtn.translatesAutoresizingMaskIntoConstraints = false
        applyBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        applyBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        applyBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        applyBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
    
    let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .orange
        return label
    }()
    
    let fromDateTxtField: UITextField = {
        let txtfield = UITextField()
        txtfield.placeholder = "yyyy/mm/dd"
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
//        txtfield.widthAnchor =  UIScreen.main.bounds.width
//        txtfield.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        txtfield.layer.borderWidth = 0.5
        txtfield.layer.cornerRadius = 3
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        txtfield.leftView = paddingView
        txtfield.rightView = paddingView
        txtfield.leftViewMode = UITextField.ViewMode.always
        txtfield.rightViewMode = UITextField.ViewMode.always
        return txtfield
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.text = "End"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .orange
        return label
    }()
    
    let endDateTxtfield: UITextField = {
        let txtfield = UITextField()
        txtfield.placeholder = "yyyy/mm/dd"
        txtfield.borderStyle = UITextField.BorderStyle.none
        txtfield.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        txtfield.layer.borderWidth = 0.5
        txtfield.layer.cornerRadius = 3
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        txtfield.leftView = paddingView
        txtfield.rightView = paddingView
        txtfield.leftViewMode = UITextField.ViewMode.always
        txtfield.rightViewMode = UITextField.ViewMode.always
        return txtfield
    }()
    
    let searchInTitle: UILabel = {
        let label = UILabel()
        label.text = "Search In"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    let searchInResult: UILabel = {
        let label = UILabel()
        label.text = "All"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    let footerStackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.leading
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .white
        return stackView
    }()
    
    let applyBtn: UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.orange
        button.setTitle("Apply Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()

}
