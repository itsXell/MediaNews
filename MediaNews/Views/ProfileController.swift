//
//  ProfileController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupUI()
    }
    
    private func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -(view.bounds.width / 2)).isActive = true
        view.addSubview(githubButton)
        githubButton.translatesAutoresizingMaskIntoConstraints = false
        githubButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor).isActive = true
        githubButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Hello, Menh Keo is here ;). \n A fresh graduate from Assumption University of Thailand. \n Check out this Medianews App's source code by: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let githubButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Github!", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(openGithub(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func openGithub(_ sender: Any?) {
        if let url = URL(string: "https://github.com/itsXell/MediaNews.git") {
            UIApplication.shared.open(url)
        }
    }
}
