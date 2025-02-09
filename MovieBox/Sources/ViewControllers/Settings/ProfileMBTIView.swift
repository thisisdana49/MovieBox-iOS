//
//  ProfileMBTIView.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import UIKit
import SnapKit

final class ProfileMBTIView: BaseView {
    
    var headerView = UIView()
    var headerLabel = UILabel()
    lazy var firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var fourthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var collectionViews: [UICollectionView] = [firstCollectionView, secondCollectionView, thirdCollectionView, fourthCollectionView]
    
    override func configureView() {
        addSubview(headerView)
        addSubview(headerLabel)
        addSubview(firstCollectionView)
        addSubview(secondCollectionView)
        addSubview(thirdCollectionView)
        addSubview(fourthCollectionView)
    }
    
    override func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(100)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(headerView.snp.trailing)
            make.width.equalTo(68)
            make.height.equalTo(140)
        }
        secondCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(firstCollectionView.snp.trailing)
            make.width.equalTo(68)
            make.height.equalTo(140)
        }
        thirdCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(secondCollectionView.snp.trailing)
            make.width.equalTo(68)
            make.height.equalTo(140)
        }
        fourthCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(thirdCollectionView.snp.trailing)
            make.width.equalTo(68)
            make.height.equalTo(140)
        }
    }
    
    override func configureHierarchy() {
        headerLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        headerLabel.text = "MBTI"
        
        for index in 0...collectionViews.count - 1 {
            collectionViews[index].tag = index
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 16
        let spacing: CGFloat = 12
        
        // TODO: Deprecated기 때문에 수정 필요
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (100) - (sectionInset * 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(cellWidth / 4, cellWidth / 4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
