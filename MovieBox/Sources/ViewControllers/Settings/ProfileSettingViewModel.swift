//
//  ProfileSettingViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import Foundation

class ProfileSettingViewModel {
    
    let inputViewDidLoad: Observable<Void?> = Observable(nil)
    let inputCompleteButtonTapped: Observable<Void?> = Observable(nil)
    
    let outputProfileImageIndex: Observable<Int> = Observable(0)
    
    init() {
        inputViewDidLoad.lazyBind { _ in
            let randomNum = Int.random(in: 0...11)
            self.outputProfileImageIndex.value = randomNum
            print("inputViewDidLoad", randomNum)
        }
        
        inputCompleteButtonTapped.lazyBind { value in
            print(#function)
        }
    }

    private func saveUserInformation() {
        print(#function)
//        let joinDate = Date().timeIntervalSince1970
//        let profileImage = mainView.profileImage
        
//        UserDefaultsManager.set(to: nickname, forKey: .userNickname)
//        UserDefaultsManager.set(to: joinDate, forKey: .joinDate)
//        UserDefaultsManager.set(to: profileImage, forKey: .profileImage)
//        UserDefaultsManager.set(to: false, forKey: .isFirst)
    }
    
}
