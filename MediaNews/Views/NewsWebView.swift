//
//  NewsWebView.swift
//  MediaNews
//
//  Created by Xell on 24/11/2564 BE.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class NewsWebView: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var urlString: String? = ""
    
    deinit {
        self.webView.stopLoading()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        setupUI()
        loadURL()
    }
    
    private func loadURL(){
        guard let url = URL(string: urlString ?? "") else { return  }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupUI() {
        view.addSubview(dismissIndicator)
        dismissIndicator.translatesAutoresizingMaskIntoConstraints = false
        dismissIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dismissIndicator.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        dismissIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dismissIndicator.heightAnchor.constraint(equalToConstant: 7).isActive = true
    }
    
    let dismissIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .lightGray
        return view
    }()
}

