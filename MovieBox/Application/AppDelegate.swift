//
//  AppDelegate.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureGlobalNavigationBarAppearance()
        configureGlobalTabBarAppearance()
        
//        UITextField.appearance().keyboardAppearance = .dark
//        UITextView.appearance().keyboardAppearance = .dark
        
        return true
    }
    
    private func configureGlobalNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .baseBlack
        appearance.titleTextAttributes = [.foregroundColor: UIColor.baseWhite]
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .mainBlue
    }
    
    private func configureGlobalTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .baseBlack
        appearance.stackedLayoutAppearance.normal.iconColor = .gray1
        appearance.stackedLayoutAppearance.selected.iconColor = .mainBlue
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray1]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.mainBlue]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = .mainBlue
    }

    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

