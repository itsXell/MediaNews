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
        loadURL()
    }
    
    private func loadURL(){
        guard let url = URL(string: urlString ?? "") else { return  }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

