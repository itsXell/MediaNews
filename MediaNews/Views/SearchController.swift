//
//  SearchController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class SearchController: UIViewController, UISearchControllerDelegate {
    
    var searchBar = UISearchController()
    var NavController: UINavigationController!
    let bag = DisposeBag()
    var currentSearch = Search(startDate: "", endDate: "", searchIn: [])
    var count = BehaviorRelay<Int>(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        configSearchBar()
        addRightNav()
        count.accept(countBadge(currentSearch))
    }
    
    func configSearchBar() {
        searchBar.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchBar.loadViewIfNeeded()
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.placeholder = "Search"
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        navigationItem.titleView = searchBar.searchBar
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
        let sortBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action: #selector(didTapSearchButton(sender:)))
        navigationItem.rightBarButtonItems = [sortBtn,filterBtn]
    }
    
    private func countBadge(_ search: Search) -> Int {
        if search.startDate == "" || search.endDate == "" {
            if search.startDate == "" && search.endDate == "" {
                return search.searchIn!.count
            } else if search.startDate == "" && search.endDate != ""{
                return search.searchIn!.count + 1
            } else {
                return search.searchIn!.count + 1
            }
        } else {
            return search.searchIn!.count + 2
        }
    }
    
    @objc func didTapFilter(sender: AnyObject){
        let vc = FilterController()
        vc.searchRelay.accept(currentSearch)
        NavController =  UINavigationController.init(rootViewController: vc)
        NavController.modalPresentationStyle = .fullScreen
        navigationController?.present(NavController, animated: true, completion: nil)
        vc.searchRelay.asObservable().subscribe(onNext: { value in
            self.currentSearch = Search(startDate: value.startDate, endDate: value.endDate, searchIn: value.searchIn)
            self.count.accept(self.countBadge(self.currentSearch))
        }).disposed(by: bag)
    }
    
    @objc func didTapSearchButton(sender: AnyObject){
        
    }
    
}
