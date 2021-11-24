//
//  SearchInController.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit

class SearchInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let view = SearchInView(frame: self.view.frame)
        self.view = view
    }
    
    


}
