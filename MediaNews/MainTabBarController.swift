//
//  MainTabBarController.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupTabBar()
    }
    
    func setupTabBar() {
        let homeNavigation = templateNavController(viewTitle:"Home", unselectImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: HomeController())
        let searchNavigation = templateNavController(viewTitle:"Search", unselectImage: UIImage(systemName: "magnifyingglass.circle")!, selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!, rootViewController: SearchController())
        let newNavigation = templateNavController(viewTitle:"News", unselectImage: UIImage(systemName: "newspaper")!, selectedImage: UIImage(systemName: "newspaper.fill")!, rootViewController: NewsListController())
        let userNavigation = templateNavController(viewTitle:"Profile", unselectImage: UIImage(systemName: "person.circle")!, selectedImage: UIImage(systemName: "person.circle.fill")!, rootViewController: ProfileController())
        let moreNavigation = templateNavController(viewTitle:"More", unselectImage: UIImage(systemName: "ellipsis.circle")!, selectedImage: UIImage(systemName: "ellipsis.circle.fill")!, rootViewController: MoreController())
        viewControllers = [homeNavigation, newNavigation, searchNavigation, userNavigation, moreNavigation]
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5 , right: 0)
        }
    }
    
    private func templateNavController(viewTitle: String, unselectImage: UIImage,  selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewNavigation = UINavigationController(rootViewController: rootViewController)
        viewNavigation.tabBarItem.image = unselectImage.withRenderingMode(.alwaysOriginal)
        viewNavigation.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        viewNavigation.tabBarItem.title = viewTitle
        viewNavigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewNavigation.navigationBar.shadowImage = UIImage()
        viewNavigation.navigationBar.isTranslucent = false
        viewNavigation.navigationBar.barTintColor = UIColor.white
        viewNavigation.navigationBar.backgroundColor = UIColor.white
        viewNavigation.view.backgroundColor = UIColor.white
        return viewNavigation
    }

}
