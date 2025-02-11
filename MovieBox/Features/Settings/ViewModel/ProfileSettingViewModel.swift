//
//  ProfileSettingViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import Foundation

class ProfileSettingViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void?> = Observable(nil)
        let nicknameText: Observable<String?> = Observable(nil)
        let mbtiCellTapped: Observable<(Int, IndexPath)?> = Observable(nil)
        let registerAvailable: Observable<Void?> = Observable(nil)
        let completeButtonTapped: Observable<Void?> = Observable(nil)
        
        let profileImageSelected: Observable<IndexPath?> = Observable(nil)
    }
    
    struct Output {
        let profileImageIndex: Observable<Int> = Observable(0)
        let guideLabel: Observable<String> = Observable("")
        let nicknameValid: Observable<Bool> = Observable(false)
        let mbtiValid: Observable<Bool> = Observable(false)
        var registerAvailable: Observable<Bool> = Observable(false)
        
        var mbtiArray: Observable<[String?]> = Observable([nil, nil, nil, nil])

        let outputSelectedProfileImage: Observable<Int> = Observable(0)
    }
    
    var randomNum: Int = 0
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    internal func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.randomNum = Int.random(in: 0...11)
            self?.output.profileImageIndex.value = self?.randomNum ?? 0
        }
        
        input.nicknameText.lazyBind { [weak self] value in
            self?.validateNickname(value)
        }
        
        input.mbtiCellTapped.lazyBind { [weak self] value in
            let (tag, indexPath): (Int, IndexPath) = value ?? (0, IndexPath(item: 0, section: 0))
            self?.configureMBTI(tag: tag, indexPath: indexPath)
        }
        
        input.registerAvailable.lazyBind { [weak self] value in
            guard let nicknameValid = self?.output.nicknameValid.value, let mbtiValid = self?.output.mbtiValid.value else { return }
            self?.output.registerAvailable.value = nicknameValid && mbtiValid
        }
        
        input.completeButtonTapped.lazyBind { value in
            print("register complete")
        }
        
        input.profileImageSelected.lazyBind { [weak self] indexPath in
            guard let indexPath = indexPath else { return }
            print("inputProfileImageSelected", indexPath.item)
            self?.output.profileImageIndex.value = indexPath.item
            self?.randomNum = indexPath.item
        }
    }
    
    private func validateNickname(_ nickname: String?) {
        guard let nickname = nickname else { return }
        print("start validate nickname", nickname)
        let specialCharacterPattern = "[@#$%]"
        let numberPattern = "\\d"
        
        if nickname.count < 2 || nickname.count >= 10 {
            output.guideLabel.value = "2글자 이상 10글자 미만으로 설정해주세요."
            output.nicknameValid.value = false
            output.registerAvailable.value = false
            return
        }
        
        if nickname.range(of: specialCharacterPattern, options: .regularExpression) != nil {
            output.guideLabel.value = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            output.nicknameValid.value = false
            return
        }
        
        if nickname.range(of: numberPattern, options: .regularExpression) != nil {
            output.guideLabel.value = "닉네임에 숫자는 포함할 수 없어요."
            output.nicknameValid.value = false
            return
        }
        
        output.guideLabel.value = "사용할 수 있는 닉네임이에요"
        output.nicknameValid.value = true
    }
    
    private func configureMBTI(tag collectionViewTag: Int, indexPath: IndexPath) {
        if collectionViewTag == 0 {
            if indexPath.item == 0 {
                output.mbtiArray.value[0] = "E"
            } else {
                output.mbtiArray.value[0] = "I"
            }
        }
        if collectionViewTag == 1 {
            if indexPath.item == 0 {
                output.mbtiArray.value[1] = "S"
            } else {
                output.mbtiArray.value[1] = "N"
            }
        }
        if collectionViewTag == 2 {
            if indexPath.item == 0 {
                output.mbtiArray.value[2] = "T"
            } else {
                output.mbtiArray.value[2] = "F"
            }
        }
        if collectionViewTag == 3 {
            if indexPath.item == 0 {
                output.mbtiArray.value[3] = "J"
            } else {
                output.mbtiArray.value[3] = "P"
            }
        }
        output.mbtiValid.value = !output.mbtiArray.value.contains(nil)
    }
    
    private func saveUserInformation() {
        print(#function)
        let joinDate = Date().timeIntervalSince1970
        let profileImage = self.randomNum
        let nickname = input.nicknameText.value ?? ""
        
        UserDefaultsManager.set(to: nickname, forKey: .userNickname)
        UserDefaultsManager.set(to: joinDate, forKey: .joinDate)
        UserDefaultsManager.set(to: profileImage, forKey: .profileImage)
        UserDefaultsManager.set(to: false, forKey: .isFirst)
    }
    
}
