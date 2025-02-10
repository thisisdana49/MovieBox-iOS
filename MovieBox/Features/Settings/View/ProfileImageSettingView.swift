//
//  ProfileImageSettingView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileImageSettingView: BaseView {
    
    var profileImage: Int = 0
    
    let imageView = UIImageView()
    let cameraImageView = UIImageView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: profileImageLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(cameraImageView)
        addSubview(collectionView)
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.layer.borderColor = UIColor.mainBlue.cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        cameraImageView.image = UIImage(systemName: "camera.fill")?.withTintColor(.baseWhite).withRenderingMode(.alwaysOriginal)
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = .mainBlue
        cameraImageView.layer.cornerRadius = 20
        cameraImageView.clipsToBounds = true
        
        collectionView.backgroundColor = .baseBlack
    }
    
    private func profileImageLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 16
        let spacing: CGFloat = 8
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (spacing * 3) - (sectionInset * 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(cellWidth / 4, cellWidth / 4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        return layout
    }
    
}
