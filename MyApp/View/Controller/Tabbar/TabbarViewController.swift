//
//  TabbarViewController.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
    }

    func configTabbar() {
        // Home
        let homeTab = HomeViewController()
        let homeTabBarItem = UITabBarItem(title: App.String.home, image: #imageLiteral(resourceName: "ic_tabbar_item_home"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_item_home"))
        homeTab.tabBarItem = homeTabBarItem
        let homeNavigationTab = BaseNavigationController(rootViewController: homeTab)
        // Favorite
        let favoriteTab = FavoriteViewController()
        let favoriteTabBarItem = UITabBarItem(title: App.String.favorite, image: #imageLiteral(resourceName: "ic_tabbar_item_favorite"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_item_favorite"))
        favoriteTab.tabBarItem = favoriteTabBarItem
        let favoriteNavigationTab = BaseNavigationController(rootViewController: favoriteTab)
        // Search
//        let searchTab = SearchViewController()
//        let searchTabBarItem = UITabBarItem(title: App.String.search, image: #imageLiteral(resourceName: "ic_tabbar_item_search"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_item_search"))
//        searchTab.tabBarItem = searchTabBarItem
//        let searchNavigationTab = BaseNavigationController(rootViewController: searchTab)
        // Setting
        let settingTab = SettingViewController()
        let settingTabBarItem = UITabBarItem(title: App.String.setting, image: #imageLiteral(resourceName: "ic_tabbar_item_setting"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_item_setting"))
        settingTab.tabBarItem = settingTabBarItem
        let settingNavigationTab = BaseNavigationController(rootViewController: settingTab)
        // Tabbar config
        tabBar.tintColor = App.Color.barTinColor
        viewControllers = [homeNavigationTab, favoriteNavigationTab, settingNavigationTab]
        tabBarController?.viewControllers = viewControllers
    }
}
