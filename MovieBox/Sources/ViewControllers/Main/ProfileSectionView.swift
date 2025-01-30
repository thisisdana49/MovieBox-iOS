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
            make.top.leading.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        profileSettingButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalTo(profileSettingButton.snp.leading)
        }
        registerDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalTo(profileSettingButton.snp.leading)
        }
        
        likeBoxButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 15
        backgroundColor = .gray3
        
        profileImageView.image = UIImage(named: "profile_\(Int.random(in: 0...11))")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.backgroundColor = .gray3
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.borderColor = UIColor.mainBlue.cgColor
        profileImageView.layer.borderWidth = 2.5
        profileImageView.clipsToBounds = true
        
        profileSettingButton.setImage(UIImage(systemName: "chevron.right")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal), for: .normal)
        
        nicknameLabel.text = "다우니맛도리탕"
        nicknameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nicknameLabel.textColor = .baseWhite
        
        registerDateLabel.text = "24.04.12 가입"
        registerDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        registerDateLabel.textColor = .gray1
    }

}
