//
//  ViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let homeVC = HomeViewController()
        let cateVC = CategoryViewController()
        let subVC = DiscoverViewController()
        let proVC = ProfileViewController()

    
        homeVC.tabBarItem = UITabBarItem.init(title: "主页", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), tag: 0)
        cateVC.tabBarItem = UITabBarItem.init(title: "分类", image: UIImage(named: "cate")!.withRenderingMode(.alwaysOriginal), tag: 1)
        subVC.tabBarItem  = UITabBarItem.init(title: "发现", image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), tag: 2)
        proVC.tabBarItem  = UITabBarItem.init(title: "我的", image: UIImage(named: "face")?.withRenderingMode(.alwaysOriginal), tag: 3)
        
        homeVC.tabBarItem.selectedImage = UIImage(named: "home.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemPink)
        cateVC.tabBarItem.selectedImage = UIImage(named: "cate.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemPink)
        subVC.tabBarItem.selectedImage = UIImage(named: "search.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemPink)
        proVC.tabBarItem.selectedImage = UIImage(named: "face.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemPink)
        
        tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().barTintColor = .white
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false
        
        let selectedColor   = UIColor.systemPink

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        
        let controllerArray = [homeVC, cateVC, subVC, proVC]
        self.viewControllers = controllerArray.map{(UINavigationController.init(rootViewController: $0))}
    }


}

