//
//  SearchView.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class SearchView: BaseView {

    let searchTextField = UISearchTextField()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureHierarchy() {
        addSubview(searchTextField)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        searchTextField.placeholder = "영화를 검색해보세요"
        
        tableView.backgroundColor = .baseBlack
    }
    
}
