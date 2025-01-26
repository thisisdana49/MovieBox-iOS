//
//  SearchDetailView.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class SearchDetailView: BaseView {

    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 200
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
//        tableView.backgroundColor = .systemPink
//        tableView.isUserInteractionEnabled = false
    }

}
