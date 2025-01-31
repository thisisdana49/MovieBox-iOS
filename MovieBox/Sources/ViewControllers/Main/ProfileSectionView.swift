//
//  ProfileSectionView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class ProfileSectionView: BaseView {

    let profileInformView = UIView()
    let profileImageView = UIImageView()
    let nicknameLabel = UILabel()
    let registerDateLabel = UILabel()
    let profileSettingButton = UIButton()
    let likeBoxButton = CustomButton(title: "0개의 무비박스 보관중", style: .filled)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileInformView)
        profileInformView.addSubview(profileImageView)
        profileInformView.addSubview(nicknameLabel)
        profileInformView.addSubview(registerDateLabel)
        profileInformView.addSubview(profileSettingButton)
        addSubview(likeBoxButton)
    }
    
    override func configureLayout() {
        profileInformView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(14)
            make.size.equalTo(48)
        }
        profileSettingButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(14)
            make.width.equalTo(12)
            make.height.equalTo(48)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(profileSettingButton.snp.leading)
        }
        registerDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(profileSettingButton.snp.leading)
        }
        
        likeBoxButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 15
        backgroundColor = .gray3
        
        profileImageView.image = UIImage(named: "profile_\(Int.random(in: 0...11))")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.backgroundColor = .gray3
        profileImageView.layer.cornerRadius = 24
        profileImageView.layer.borderColor = UIColor.mainBlue.cgColor
        profileImageView.layer.borderWidth = 2.5
        profileImageView.clipsToBounds = true
        
        profileSettingButton.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.gray2).withRenderingMode(.alwaysOriginal), for: .normal)
        
        nicknameLabel.text = "다우니맛도리탕"
        nicknameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nicknameLabel.textColor = .baseWhite
        
        registerDateLabel.text = "24.04.12 가입"
        registerDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        registerDateLabel.textColor = .gray2
    }
    
    func updateUserInfo() {
        guard let profileImageIndex = UserDefaultsManager.get(forKey: .profileImage) as? Int,
              let nickname = UserDefaultsManager.get(forKey: .userNickname) as? String,
              let registerDateStamp = UserDefaultsManager.get(forKey: .joinDate) as? Double
        else {
            print(UserDefaultsManager.get(forKey: .profileImage) as? Int)
            print(UserDefaultsManager.get(forKey: .userNickname) as? String)
            print(UserDefaultsManager.get(forKey: .joinDate) as? Double)
            
            profileImageView.image = UIImage(named: "profile_0")
            nicknameLabel.text = "사용자"
            registerDateLabel.text = "yy.MM.dd 가입"

            return
        }

        let registerDate = Date(timeIntervalSince1970: registerDateStamp)
        let formattedDate = registerDate.toFormattedString("yy.MM.dd")
        
        profileImageView.image = UIImage(named: "profile_\(profileImageIndex)")
        nicknameLabel.text = nickname
        registerDateLabel.text = "\(formattedDate) 가입"
    }

}
