//
//  SettingsView.swift
//  MovieBox
//
//  Created by 조다은 on 1/29/25.
//

import UIKit

class SettingsView: BaseView {

    let profileSection = ProfileSectionView()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileSection)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        profileSection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(130)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileSection.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
