//
//  SplashView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class SplashView: BaseView {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.size.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.image = .splash
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "MovieBox"
        titleLabel.font = UIFont.italicSystemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .baseWhite
        
        subtitleLabel.text = "조다은"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = .gray1
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
    }
}
