//
//  SearchController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class SearchController: UIViewController, UISearchControllerDelegate {
    
    var searchBar = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        configSearchBar()
        addRightNav()
    }
    
    func configSearchBar() {
        
        //        searchBar = UISearchController(searchResultsController: resultsTableViewController)
        searchBar.delegate = self
        //            controladorDeBusca.searchResultsUpdater = resultsTableViewController
        searchBar.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        searchBar.loadViewIfNeeded()
        
        //Configura a barra do Controlador de busca
        //            controladorDeBusca.searchBar.delegate = resultsTableViewController
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.placeholder = "Search "
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        searchBar.searchBar.tintColor = self.view.tintColor
        
        //Adiciona a barra do Controlador de Busca a barra do navegador
        navigationItem.titleView = searchBar.searchBar
    }
    
    private func addRightNav() {
        let filterImg    = UIImage(systemName: "line.horizontal.3.decrease.circle")
        let sortImg  = UIImage(systemName: "arrow.up.arrow.down.circle")!
        
        let sortBtn   = UIBarButtonItem(image: sortImg,  style: .plain, target: self, action: #selector(didTapFilter(sender:)))
        let filterBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action: #selector(didTapSearchButton(sender:)))
        
        navigationItem.rightBarButtonItems = [filterBtn, sortBtn]
    }
    
    @objc func didTapFilter(sender: AnyObject){
        let vc = FilterController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSearchButton(sender: AnyObject){
        
    }
    
}
