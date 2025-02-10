//
//  ProfileImageCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import SnapKit

final class ProfileImageCollectionViewCell: UICollectionViewCell {
        
    let profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        backgroundColor = .clear
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.gray2.cgColor
        profileImageView.alpha = 0.5
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            profileImageView.layer.borderWidth = 2
            profileImageView.layer.borderColor = UIColor.mainBlue.cgColor
            profileImageView.alpha = 1
        } else {
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.gray2.cgColor
            profileImageView.alpha = 0.5
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
}
