//
//  CustomLikeButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class CustomLikeButton: UIButton {

    let selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal)
    let unselectedImage = UIImage(systemName: "heart")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        
        config.image = isSelected ? selectedImage : unselectedImage
        configuration = config

        isEnabled = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
    }
    
    @objc
    private func buttonTapped() {
        print(#function)
        isSelected.toggle()
        updateButtonUI()
    }
    
    private func updateButtonUI() {
        var config = configuration
        if isSelected {
            config?.image = selectedImage
        } else {
            config?.image = unselectedImage
        }
        configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
