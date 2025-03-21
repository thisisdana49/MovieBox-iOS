//
//  ProfileSettingView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileSettingView: BaseView {
    
    let imageView = UIImageView()
    let cameraImageView = UIImageView()
    let textField = CustomTextField()
    let guideLabel = UILabel()
    let mbtiSection = ProfileMBTIView()
    let completeButton = CustomButton(title: "완료", style: .bordered)
    
    init(mode: ProfileSettingMode) {
        super.init(frame: .zero)
        
//        switch mode {
//        case .onboarding:
//            profileImage = Int.random(in: 0...11)
//        case .edit(let currentNickname):
//            profileImage = UserDefaultsManager.get(forKey: .profileImage) as? Int ?? 0
//            textField.text = currentNickname
//            completeButton.isHidden = true
//        }
//        print(#function, profileImage)
//        imageView.image = UIImage(named: "profile_\(profileImage)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: textField.frame.height + 12, width: textField.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor.gray1.cgColor
        textField.layer.addSublayer(bottomBorder)
    }
    
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(cameraImageView)
        addSubview(textField)
        addSubview(guideLabel)
        addSubview(mbtiSection)
        addSubview(completeButton)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        cameraImageView.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.trailing.equalTo(imageView.snp.trailing)
            make.size.equalTo(40)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        mbtiSection.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(48)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        backgroundColor = .baseWhite
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.layer.borderColor = UIColor.pointBlue.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withTintColor(.baseWhite).withRenderingMode(.alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .pointBlue
        cameraImageView.layer.cornerRadius = 20
        cameraImageView.clipsToBounds = true
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray2,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: attributes)
        textField.textColor = .baseBlack
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        
        // TODO: extension으로 빼기
        guideLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
}
