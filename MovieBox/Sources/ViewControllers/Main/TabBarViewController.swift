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
        
        mainVC.tabBarItem.image = UIImage.init(systemName: "popcorn")
        upcoimingVC.tabBarItem.image = UIImage.init(systemName: "film.stack")
        settingsVC.tabBarItem.image = UIImage.init(systemName: "person.crop.circle")
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        let navMainVC = UINavigationController(rootViewController: mainVC)
        let navUpcomingVC = UINavigationController(rootViewController: upcoimingVC)
        let navSettingsVC = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers([navMainVC, navUpcomingVC, navSettingsVC], animated: false)
    }
    
}
