//
//  ProfileSettingView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class ProfileSettingView: BaseView {

    let imageView = UIImageView()
    let cameraImageView = UIImageView()
    let textField = UITextField()
    let guideLabel = UILabel()
    let completeButton = CustomButton(title: "완료")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(cameraImageView)
        addSubview(textField)
        addSubview(guideLabel)
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
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        super.configureView()

        imageView.image = UIImage(named: "profile_\(Int.random(in: 0...11))")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.layer.borderColor = UIColor.mainBlue.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withTintColor(.baseWhite).withRenderingMode(.alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .mainBlue
        cameraImageView.layer.cornerRadius = 20
        cameraImageView.clipsToBounds = true
        
        textField.textColor = .baseWhite
        
        guideLabel.text = "사용할 수 있는 닉네임이에요"
        guideLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        guideLabel.textColor = .mainBlue
    }
    
}
