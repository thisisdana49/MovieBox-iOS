//
//  ProfileImageSettingView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class ProfileImageSettingView: BaseView {
    
    var profileImage: String = ""
    
    let imageView = UIImageView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: profileImageLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function, profileImage)
        
    }
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
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
