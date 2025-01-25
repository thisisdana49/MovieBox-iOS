//
//  MainView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class MainView: BaseView {

    let profileSectionView = ProfileSectionView()
    let recentKeywordsView = RecentKeywordTableViewCell()
    let movieTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileSectionView)
        addSubview(recentKeywordsView)
        addSubview(movieTableView)
    }
    
    override func configureLayout() {
        profileSectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(130)
        }
        
        recentKeywordsView.snp.makeConstraints { make in
            make.top.equalTo(profileSectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(recentKeywordsView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        recentKeywordsView.titleLabel.text = "최근 검색어"
    }
    
}
