//
//  TabBarController.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/11.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newsVC = NewsViewController()
        newsVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        
        let favoriteVC = FavoriteController()
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.favorites, tag: 0)
        viewControllers = [newsVC, favoriteVC]
        
    }
    
}
