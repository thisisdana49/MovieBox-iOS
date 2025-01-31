//
//  SplashViewController.swift
//  MovieBox
//
//  Created by 조다은 on 2/1/25.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    let mainView = SplashView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.switchToNextScreen()
        }
    }
    
    private func switchToNextScreen() {
        var nextVC: UIViewController
        
        if UserDefaultsManager.get(forKey: .isFirst) == nil {
            UserDefaultsManager.set(to: true, forKey: .isFirst)
        }
        
        if let userIsFirst = UserDefaultsManager.get(forKey: .isFirst) as? Bool, userIsFirst == false {
            nextVC = TabBarViewController()
        } else {
            nextVC = UINavigationController(rootViewController: OnboardingViewController())
        }
        
        // TODO: Network 연결 확인 추가
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = nextVC
        })
    }
    
}
