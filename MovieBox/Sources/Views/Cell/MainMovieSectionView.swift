//
//  MainMovieSectionView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class MainMovieSectionView: BaseView {

    let headerLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureHierarchy() {
        addSubview(headerLabel)
        addSubview(collectionView)
    }

    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaInsets)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        headerLabel.text = "오늘의 영화"
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        headerLabel.textColor = .baseWhite
        
        collectionView.backgroundColor = .baseBlack
    }
    
    static private func layout() -> UICollectionViewLayout {
        let inset: CGFloat = 16
        let spacing: CGFloat = 12
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - spacing - inset
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth / 1.7, height: cellWidth / 1.7 * 1.8)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
