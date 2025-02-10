//
//  CustomKeywordButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import SnapKit

final class CustomKeywordButton: UIView {
    
    var name: String = ""
    
    private let titleLabel = UILabel()
    private let xmarkButton = UIButton(type: .system)
    
    var onKeywordTapped: (() -> Void)?
    var onXmarkTapped: (() -> Void)?
    
    init(title: String) {
        super.init(frame: .zero)
        name = title
        setupView()
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keywordTapped))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        
        backgroundColor = .baseWhite
        layer.cornerRadius = 17.5
        layer.masksToBounds = true
        
        titleLabel.text = name
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .baseBlack
        
        xmarkButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xmarkButton.tintColor = .baseBlack
        xmarkButton.addTarget(self, action: #selector(xmarkTapped), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(xmarkButton)
        
        
        snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.greaterThanOrEqualTo(60)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }

    }
    
    @objc
    private func keywordTapped() {
        onKeywordTapped?()
    }
    
    @objc
    private func xmarkTapped() {
        onXmarkTapped?()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
