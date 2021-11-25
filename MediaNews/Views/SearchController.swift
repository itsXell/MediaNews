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
import Presentr

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var NavController: UINavigationController!
    var tableView = UITableView()
    var titleLabel = UILabel()
    var spinner = UIActivityIndicatorView()
    var friendlyLabel = UILabel()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search ..."
        return searchBar
    }()
    let cellID = "CellID"
    let historyCellID = "CellID"
    
    let bag = DisposeBag()
    var count = BehaviorRelay<Int>(value: 0)
    private var articles: ArticleListVM!
    var currentFilter = BehaviorRelay<Filter>(value: Filter(startDate: "", endDate: "", searchIn: []))
    var sortBy = BehaviorRelay<String>(value: "publishedAt")
    var searchKeyWord = BehaviorRelay<String>(value: "")
    var history: [String] = []
    var isHistoryCell = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupSearchBar()
        addRightNav()
        setupUI()
        registerTableview()
        count.accept(CalculateBadge.countBadge(self.currentFilter))
        bindValueWhenLoaded()
    }
    
    /* Begin of UI Related function*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    private func setupUI() {
        let view = SearchView(frame: self.view.frame)
        self.tableView = view.tableView
        self.titleLabel = view.titleLabel
        self.spinner = view.spinner
        self.friendlyLabel = view.friendlyLabel
        self.view = view
    }
    
    private func registerTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellID)
//        tableView.register(HistoryCell.nib(), forCellReuseIdentifier: HistoryviewCell.id)
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
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        filterButton.setBackgroundImage(UIImage(systemName: "arrow.up.arrow.down.circle")!, for: .normal)
        filterButton.addTarget(self, action: #selector(didTapFilter(sender:)), for: .touchUpInside)
        filterButton.addSubview(label)
        let filterImg    = UIImage(systemName: "line.horizontal.3.decrease.circle")
        let filterBtn   = UIBarButtonItem(customView: filterButton)
        let sortBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action: #selector(didTapSortButton(sender:)))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelSearch))
        navigationItem.rightBarButtonItems = [sortBtn,filterBtn, cancelBtn]
    }
    
    /* End of UI Related function*/
    
    /* Begin of Action Function*/
    
    private func fetApi(keyword: String, filter: BehaviorRelay<Filter>, sortBy: BehaviorRelay<String>) {
        self.friendlyLabel.isHidden = true
        spinner.startAnimating()
        guard let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let keyword = URL(string: keywordEncode) else {
            return
        }
        let body = URLBodyGenerator().urlBodyGenerator(filter: filter.value, sortBy: sortBy.value)
        let searchUrl = "https://gnews.io/api/v4/search?q=\(keyword)&\(body)&token=\(ApiKey.apiKey)"
        let urlResource = Resource<MainArticle>(url: URL(string: searchUrl)!)
        URLRequest.load(resource: urlResource).observe(on: MainScheduler.instance).retry(3).catchAndReturn(MainArticle(articles: [])) .subscribe(onNext: { articles in
            let articles = articles.articles
            self.articles = ArticleListVM(articlesList: articles)
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                if articles.count == 0 {
                    self.titleLabel.text = "0 News"
                    self.friendlyLabel.isHidden = false
                } else {
                    self.titleLabel.text = "\(articles.count) News"
                    self.friendlyLabel.isHidden = true
                }
                self.tableView.reloadData()
            }
        }).disposed(by: bag)
    }
    
    private func bindValueWhenLoaded() {
        searchKeyWord.bind(onNext: { txt in
            if txt != "" {
                self.fetApi(keyword: txt, filter: self.currentFilter, sortBy: self.sortBy)
            } else {
                self.tableView.reloadData()
            }
        }).disposed(by: bag)
        sortBy.bind(onNext: { sort in
            if self.searchKeyWord.value != "" {
                self.fetApi(keyword: self.searchKeyWord.value, filter: self.currentFilter, sortBy: self.sortBy)
            }
        }).disposed(by: bag)
        currentFilter.bind(onNext: { filter in
            if self.searchKeyWord.value != "" {
                self.fetApi(keyword: self.searchKeyWord.value, filter: self.currentFilter, sortBy: self.sortBy)
            }
        }).disposed(by: bag)
    }
    
    /* End of Action Function*/
    
    /* Begin of Didtap Action Function*/
    
    @objc func didTapFilter(sender: AnyObject){
        let vc = FilterController()
        vc.searchRelay.accept(currentFilter.value)
        NavController =  UINavigationController.init(rootViewController: vc)
        NavController.modalPresentationStyle = .fullScreen
        navigationController?.present(NavController, animated: true, completion: nil)
        vc.searchRelay.asObservable().subscribe(onNext: { value in
            self.currentFilter.accept(Filter(startDate: value.startDate, endDate: value.endDate, searchIn: value.searchIn))
            self.count.accept(CalculateBadge.countBadge(self.currentFilter))
        }).disposed(by: bag)
    }
    
    @objc func didTapSortButton(sender: AnyObject){
        let controller = SortByController()
        if sortBy.value == "publishedAt" {
            controller.selectedMockup.accept("Upload date")
        } else {
            controller.selectedMockup.accept("Relevance")
        }
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
        controller.selectedValue.asObservable().subscribe(onNext: { data in
            self.sortBy.accept(data)
        }).disposed(by: bag)
    }
    
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.5)
        let center = ModalCenterPosition.bottomCenter
        let presentr = Presentr(presentationType: .custom(width: width, height: height, center: center))
        presentr.roundCorners = true
        presentr.cornerRadius = 10
        presentr.backgroundColor = UIColor.black
        presentr.backgroundOpacity = 0.7
        presentr.transitionType = .coverVertical
        presentr.dismissTransitionType = .coverVertical
        presentr.dismissOnSwipe = true
        presentr.dismissAnimated = true
        presentr.dismissOnSwipeDirection = .default
        return presentr
    }()
    
    @IBAction private func cancelSearch(){
        titleLabel.text = "History"
        searchBar.text = ""
        searchKeyWord.accept("")
        isHistoryCell = true
    }
    
    /* End of Did tap Function*/
    
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        searchKeyWord.accept(text)
        if !history.contains(text) {
            self.history.append(text)
        }
        self.searchBar.endEditing(true)
    }
    
}

extension SearchController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchKeyWord.value == "" {
            return 50
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchKeyWord.value == "" {
            return history.count
        } else {
            if articles == nil {
                return 0
            } else {
                return articles.articleListVM.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsCell
        if searchKeyWord.value == "" {
            cell.backgroundUIView.backgroundColor = .clear
            cell.titleImage.isHidden = true
            cell.titleLabel.isHidden = true
            cell.descriptionLabel.isHidden = true
            cell.historyLabel.isHidden = false
            cell.historyLabel.text = history[indexPath.row]
        } else {
            isHistoryCell = false
            cell.historyLabel.isHidden = true
            cell.titleImage.isHidden = false
            cell.titleLabel.isHidden = false
            cell.descriptionLabel.isHidden = false
            cell.titleImage.isHidden = false
            cell.backgroundUIView.backgroundColor = .white
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
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if !isHistoryCell {
            let nextVc = NewsWebView()
            let selectedUrl = articles.indexAt(index: indexPath.row).url
            selectedUrl.subscribe(onNext: {
                nextVc.urlString = $0
            }).disposed(by: bag)
            self.present(nextVc, animated: true, completion: nil)
        } else {
            searchBar.text = history[indexPath.row]
            searchKeyWord.accept(history[indexPath.row])
        }
      
    }
}
