//
//  ProfileSettingViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import Foundation

class ProfileSettingViewModel {
    
    let inputViewDidLoad: Observable<Void?> = Observable(nil)
    let inputNicknameText: Observable<String?> = Observable(nil)
    let inputCompleteButtonTapped: Observable<Void?> = Observable(nil)
    
    let outputProfileImageIndex: Observable<Int> = Observable(0)
    let outputGuideLabel: Observable<String> = Observable("")
    let outputNicknameValid: Observable<Bool> = Observable(false)
    
    var randomNum: Int = 0
    
    init() {
        inputViewDidLoad.lazyBind { [weak self] _ in
            self?.randomNum = Int.random(in: 0...11)
            self?.outputProfileImageIndex.value = self?.randomNum ?? 0
            print("inputViewDidLoad", self?.randomNum)
        }
        
        inputNicknameText.lazyBind { [weak self] value in
            self?.validateNickname(value)
        }
        
        inputCompleteButtonTapped.lazyBind { value in
            print(#function)
        }
    }

    private func validateNickname(_ nickname: String?) {
        guard let nickname = nickname else { return }
        print("start validate nickname", nickname)
        let specialCharacterPattern = "[@#$%]"
        let numberPattern = "\\d"
        
//        mainView.guideLabel.isHidden = false
        if nickname.count < 2 || nickname.count >= 10 {
//            mainView.guideLabel.text = "2글자 이상 10글자 미만으로 설정해주세요."
//            mainView.guideLabel.textColor = .red
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "2글자 이상 10글자 미만으로 설정해주세요."
            outputNicknameValid.value = false
            return
        }
        
        if nickname.range(of: specialCharacterPattern, options: .regularExpression) != nil {
//            mainView.guideLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요."
//            mainView.guideLabel.textColor = .red
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            outputNicknameValid.value = false
            return
        }
        
        if nickname.range(of: numberPattern, options: .regularExpression) != nil {
//            mainView.guideLabel.text = "닉네임에 숫자는 포함할 수 없어요."
//            mainView.guideLabel.textColor = .red
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "닉네임에 숫자는 포함할 수 없어요."
            outputNicknameValid.value = false
            return
        }
        
        outputGuideLabel.value = "사용할 수 있는 닉네임이에요"
        outputNicknameValid.value = true
//        mainView.guideLabel.textColor = .mainBlue
//        mainView.completeButton.isEnabled = true
    }
    
    private func saveUserInformation() {
        print(#function)
        let joinDate = Date().timeIntervalSince1970
        let profileImage = self.randomNum
        
//        UserDefaultsManager.set(to: nickname, forKey: .userNickname)
        UserDefaultsManager.set(to: joinDate, forKey: .joinDate)
        UserDefaultsManager.set(to: profileImage, forKey: .profileImage)
        UserDefaultsManager.set(to: false, forKey: .isFirst)
    }
    
}
