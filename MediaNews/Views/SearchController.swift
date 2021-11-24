//
//  SearchController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var NavController: UINavigationController!
    let bag = DisposeBag()
    var currentSearch = Filter(startDate: "", endDate: "", searchIn: [])
    var count = BehaviorRelay<Int>(value: 0)
    var tableView = UITableView()
    private var articles: ArticleListVM!
    let cellID = "CellID"
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search ..."
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupSearchBar()
        addRightNav()
        setupUI()
        registerTableview()
        count.accept(CalculateBadge.countBadge(self.currentSearch))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    private func setupUI() {
        let view = SearchView(frame: self.view.frame)
        self.tableView = view.tableView
        self.view = view
    }
    
    private func registerTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellID)
    }
   
    private func setupSearchBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    
    private func addRightNav() {
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.backgroundColor = .red
        self.count.map({ c -> String in
            return String(c)
        }).bind(onNext: { c in
            if c == "0" {
                label.isHidden = true
            } else {
                label.isHidden = false
                label.rx.text.onNext(c)
            }
        }).disposed(by: bag)
        
        // button
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        filterButton.setBackgroundImage(UIImage(systemName: "arrow.up.arrow.down.circle")!, for: .normal)
        filterButton.addTarget(self, action: #selector(didTapFilter(sender:)), for: .touchUpInside)
        filterButton.addSubview(label)

        let filterImg    = UIImage(systemName: "line.horizontal.3.decrease.circle")
        
        let filterBtn   = UIBarButtonItem(customView: filterButton)
        let sortBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action: #selector(didTapSortButton(sender:)))
        navigationItem.rightBarButtonItems = [sortBtn,filterBtn]
    }
    
    @objc func didTapFilter(sender: AnyObject){
        let vc = FilterController()
        vc.searchRelay.accept(currentSearch)
        NavController =  UINavigationController.init(rootViewController: vc)
        NavController.modalPresentationStyle = .fullScreen
        navigationController?.present(NavController, animated: true, completion: nil)
        vc.searchRelay.asObservable().subscribe(onNext: { value in
            self.currentSearch = Filter(startDate: value.startDate, endDate: value.endDate, searchIn: value.searchIn)
            self.count.accept(CalculateBadge.countBadge(self.currentSearch))
        }).disposed(by: bag)
    }
    
    @objc func didTapSortButton(sender: AnyObject){
        
    }
    
    private func fetApi(keyword: String, filter: Filter) {
        guard let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let keyword = URL(string: keywordEncode) else {
            return
        }
        let urlResource = Resource<MainArticle>(url: URL(string: "https://gnews.io/api/v4/search?q=\(keyword)&token=\(ApiKey.apiKey)")!)
        URLRequest.load(resource: urlResource).subscribe(onNext: { articles in
            let articles = articles.articles
            self.articles = ArticleListVM(articlesList: articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: bag)
    }
    
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        fetApi(keyword: text, filter: currentSearch)
    }
    
}

extension SearchController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsCell
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
