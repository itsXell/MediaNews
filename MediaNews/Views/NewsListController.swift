//
//  NewsListController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage

class NewsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let tableCellID = "Cell"
    private var articles: ArticleListVM!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        registerTableViewCell()
        fetchApi()
    }
    
    private func initialView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Media News"
        view.backgroundColor = .lightGray
        let view = NewsListView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableViewCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: tableCellID)
    }
    
    private func fetchApi() {
        let urlResource = Resource<MainArticle>(url: URL(string: "https://gnews.io/api/v4/search?q=example&token=\(ApiKey.apiKey)")!)
        URLRequest.load(resource: urlResource).subscribe(onNext: { articles in
            let articles = articles.articles
            self.articles = ArticleListVM(articlesList: articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: bag)
    }
    
}

extension NewsListController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articles == nil {
            return 0
        } else {
            return articles.articleListVM.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! NewsCell
        let currentArticle = articles.indexAt(index: indexPath.row)
        currentArticle.title.asDriver(onErrorJustReturn: "Fail to Retrieve").drive(cell.titleLabel.rx.text).disposed(by: bag)
        currentArticle.description.asDriver(onErrorJustReturn: "Fail to Retrieve").drive(cell.descriptionLabel.rx.text).disposed(by: bag)
        currentArticle.image.asDriver(onErrorJustReturn: "").drive(onNext: { url in
            AF.request(url).responseImage { response in
                if case .success(let image) = response.result {
                    cell.titleImage.image = image
                }
            }
        }).disposed(by: bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let nextVc = NewsWebView()
        let selectedUrl = articles.indexAt(index: indexPath.row).url
        selectedUrl.subscribe(onNext: {
            nextVc.urlString = $0
        }).disposed(by: bag)
        self.present(nextVc, animated: true, completion: nil)
    }
}
