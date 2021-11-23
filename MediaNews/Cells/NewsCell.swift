//
//  NewsCell.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class NewsCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleImage.widthAnchor.constraint(equalToConstant: self.bounds.width / 2).isActive = true
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
    }
    
    let titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
}
