//
//  MainView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class MainView: BaseView {

    let profileSection = ProfileSectionView()
    let recentKeywordsView = RecentKeywordTableViewCell()
    let todaysMovieSection = MainMovieSectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileSection)
        addSubview(recentKeywordsView)
        addSubview(todaysMovieSection)
    }
    
    override func configureLayout() {
        profileSection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(130)
        }
        
        recentKeywordsView.snp.makeConstraints { make in
            make.top.equalTo(profileSection.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        todaysMovieSection.snp.makeConstraints { make in
            make.top.equalTo(recentKeywordsView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        recentKeywordsView.headerLabel.text = "최근 검색어"
    }
    
}
