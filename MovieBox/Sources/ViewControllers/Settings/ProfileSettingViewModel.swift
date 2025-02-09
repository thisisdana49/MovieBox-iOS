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
    let inputMBTICellTapped: Observable<(Int, IndexPath)?> = Observable(nil)
    let inputRegisterAvailable: Observable<Void?> = Observable(nil)
    let inputCompleteButtonTapped: Observable<Void?> = Observable(nil)
    
    let outputProfileImageIndex: Observable<Int> = Observable(0)
    let outputGuideLabel: Observable<String> = Observable("")
    let outputNicknameValid: Observable<Bool> = Observable(false)
    let outputMBTIValid: Observable<Bool> = Observable(false)
    var outputRegisterAvailable: Observable<Bool> = Observable(false)
    
    var randomNum: Int = 0
    var outputMBTIArray: Observable<[String?]> = Observable([nil, nil, nil, nil])
    
    init() {
        inputViewDidLoad.lazyBind { [weak self] _ in
            self?.randomNum = Int.random(in: 0...11)
            self?.outputProfileImageIndex.value = self?.randomNum ?? 0
        }
        
        inputNicknameText.lazyBind { [weak self] value in
            self?.validateNickname(value)
        }
        
        inputMBTICellTapped.lazyBind { [weak self] value in
            let (tag, indexPath): (Int, IndexPath) = value ?? (0, IndexPath(item: 0, section: 0))
            self?.configureMBTI(tag: tag, indexPath: indexPath)
        }
        
        inputRegisterAvailable.lazyBind { [weak self] value in
//            self?.outputRegisterAvailable.value = (self?.outputNicknameValid.value)! && (self?.outputMBTIValid.value)!
            guard let nicknameValid = self?.outputNicknameValid.value, let mbtiValid = self?.outputMBTIValid.value else { return }
            self?.outputRegisterAvailable.value = nicknameValid && mbtiValid
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
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "2글자 이상 10글자 미만으로 설정해주세요."
            outputNicknameValid.value = false
            outputRegisterAvailable.value = false
            return
        }
        
        if nickname.range(of: specialCharacterPattern, options: .regularExpression) != nil {
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            outputNicknameValid.value = false
            return
        }
        
        if nickname.range(of: numberPattern, options: .regularExpression) != nil {
//            mainView.completeButton.isEnabled = false
            outputGuideLabel.value = "닉네임에 숫자는 포함할 수 없어요."
            outputNicknameValid.value = false
            return
        }
        
        outputGuideLabel.value = "사용할 수 있는 닉네임이에요"
        outputNicknameValid.value = true
//        mainView.completeButton.isEnabled = true
    }
    
    private func configureMBTI(tag collectionViewTag: Int, indexPath: IndexPath) {
        if collectionViewTag == 0 {
            if indexPath.item == 0 {
                outputMBTIArray.value[0] = "E"
            } else {
                outputMBTIArray.value[0] = "I"
            }
        }
        if collectionViewTag == 1 {
            if indexPath.item == 0 {
                outputMBTIArray.value[1] = "S"
            } else {
                outputMBTIArray.value[1] = "N"
            }
        }
        if collectionViewTag == 2 {
            if indexPath.item == 0 {
                outputMBTIArray.value[2] = "T"
            } else {
                outputMBTIArray.value[2] = "F"
            }
        }
        if collectionViewTag == 3 {
            if indexPath.item == 0 {
                outputMBTIArray.value[3] = "J"
            } else {
                outputMBTIArray.value[3] = "P"
            }
        }
        outputMBTIValid.value = !outputMBTIArray.value.contains(nil)
        print(outputMBTIArray.value, outputMBTIValid.value)
    }
    
    private func saveUserInformation() {
        print(#function)
        let joinDate = Date().timeIntervalSince1970
        let profileImage = self.randomNum
        let nickname = inputNicknameText.value ?? ""
        
        UserDefaultsManager.set(to: nickname, forKey: .userNickname)
        UserDefaultsManager.set(to: joinDate, forKey: .joinDate)
        UserDefaultsManager.set(to: profileImage, forKey: .profileImage)
        UserDefaultsManager.set(to: false, forKey: .isFirst)
    }
    
}
