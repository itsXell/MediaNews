//
//  MoreController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class MoreController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupUI()
    }
    
    private func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "More"
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "This view is under maintainance!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
}
