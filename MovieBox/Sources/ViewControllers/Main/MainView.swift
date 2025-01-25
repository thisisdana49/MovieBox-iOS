//
//  MainView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class MainView: BaseView {

    let profileSectionView = ProfileSectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileSectionView)
    }
    
    override func configureLayout() {
        profileSectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(130)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
    
}
