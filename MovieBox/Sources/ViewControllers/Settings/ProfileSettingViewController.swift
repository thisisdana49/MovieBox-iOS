//
//  ProfileSettingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    
    let mainView = ProfileSettingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    fileprivate func configureViewController() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        mainView.imageView.addGestureRecognizer(tapGesture)
        
        mainView.textField.delegate = self
        mainView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        navigationItem.title = "프로필 설정"
    }
    
    @objc
    func imageViewTapped() {
        let vc = ProfileImageSettingViewController()
        vc.profileImage = mainView.profileImage
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func completeButtonTapped() {
        UserDefaultsManager.set(to: false, forKey: .isFirst)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
    }
}

// MARK: TextField Delegate
extension ProfileSettingViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
}
