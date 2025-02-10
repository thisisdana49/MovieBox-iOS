//
//  SettingsView.swift
//  MovieBox
//
//  Created by 조다은 on 1/29/25.
//

import UIKit

final class SettingsView: BaseView {

    let profileSection = ProfileSectionView()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(profileSection)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        profileSection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(130)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileSection.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.backgroundColor = .baseBlack
        tableView.separatorColor = .gray2
        tableView.separatorInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        tableView.rowHeight = 60
    }
}
