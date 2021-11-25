//
//  HomeController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupUI()
    }
    
    private func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Home"
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -(view.bounds.width / 3)).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "This is News App where you can search for News base on different category such as Published date, Relevance, Title, Content and Description. \n The article are view in webview where you can read directly from the original source. Enjoy! ;)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
}
