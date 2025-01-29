//
//  OnboardingView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class OnboardingView: BaseView {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let startButton = CustomButton(title: "시작하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(startButton)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.image = .onboarding
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.text = "Onboarding"
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .baseWhite
        
        subtitleLabel.text = "당신만의 영화 세상.\nMovieBox를 시작해 보세요."
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = .baseWhite
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
    }
}
