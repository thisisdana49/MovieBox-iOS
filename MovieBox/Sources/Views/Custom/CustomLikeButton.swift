//
//  CustomLikeButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class CustomLikeButton: UIButton {
    
    private var movieID: Int = 0
    
    let selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal)
    let unselectedImage = UIImage(systemName: "heart")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    func setMovieID(_ id: Int) {
        self.movieID = id
        updateButtonUI()
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
        isSelected.toggle()
        if isSelected {
            UserDefaultsManager.saveLikedMovie(movieID)
        } else {
            UserDefaultsManager.removeLikedMovie(movieID)
        }
        updateButtonUI()
        NotificationCenter.default.post(
            name: NSNotification.Name("reloadCollectionView"),
            object: nil
        )
    }
    
    private func updateButtonUI() {
        var config = configuration
        if UserDefaultsManager.isLikedMovie(movieID) {
            config?.image = selectedImage
            isSelected = true
        } else {
            config?.image = unselectedImage
            isSelected = false
        }
        configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
