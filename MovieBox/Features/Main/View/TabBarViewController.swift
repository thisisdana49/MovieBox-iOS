//
//  TabBarViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = MainViewController()
        let upcoimingVC = MainViewController()
        let settingsVC = SettingsViewController()
        
        mainVC.tabBarItem = UITabBarItem(title: "CINEMA", image: UIImage(systemName: "popcorn"), selectedImage: UIImage(systemName: "popcorn.fill"))
        upcoimingVC.tabBarItem = UITabBarItem(title: "UPCOMING", image: UIImage(systemName: "film.stack"), selectedImage: UIImage(systemName: "film.stack.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        let navMainVC = UINavigationController(rootViewController: mainVC)
        let navUpcomingVC = UINavigationController(rootViewController: upcoimingVC)
        let navSettingsVC = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers([navMainVC, navUpcomingVC, navSettingsVC], animated: false)
    }
    
}
