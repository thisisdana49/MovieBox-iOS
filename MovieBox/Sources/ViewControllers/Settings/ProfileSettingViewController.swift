//
//  ProfileSettingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    
    var nickname: String = ""
    let mainView = ProfileSettingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.textField.becomeFirstResponder()
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
        let joinDate = Date().timeIntervalSince1970
        let profileImage = mainView.profileImage
        
        UserDefaultsManager.set(to: nickname, forKey: .userNickname)
        UserDefaultsManager.set(to: joinDate, forKey: .joinDate)
        UserDefaultsManager.set(to: profileImage, forKey: .profileImage)
        UserDefaultsManager.set(to: false, forKey: .isFirst)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
    }
}

// MARK: TextField Delegated
extension ProfileSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text else {
            print(#function)
            return
        }
        nickname = inputText
        validateNickname(nickname)
    }
    
    func validateNickname(_ nickname: String) {
        let specialCharacterPattern = "[@#$%]"
        let numberPattern = "\\d"
        
        mainView.guideLabel.isHidden = false
        if nickname.count < 2 || nickname.count >= 10 {
            mainView.guideLabel.text = "2글자 이상 10글자 미만으로 설정해주세요."
            mainView.guideLabel.textColor = .red
            mainView.completeButton.isEnabled = false
            return
        }
        
        if nickname.range(of: specialCharacterPattern, options: .regularExpression) != nil {
            mainView.guideLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            mainView.guideLabel.textColor = .red
            mainView.completeButton.isEnabled = false
            return
        }
        
        if nickname.range(of: numberPattern, options: .regularExpression) != nil {
            mainView.guideLabel.text = "닉네임에 숫자는 포함할 수 없어요."
            mainView.guideLabel.textColor = .red
            mainView.completeButton.isEnabled = false
            return
        }
        mainView.guideLabel.text = "사용할 수 있는 닉네임이에요"
        mainView.guideLabel.textColor = .mainBlue
        mainView.completeButton.isEnabled = true
    }
    
}
