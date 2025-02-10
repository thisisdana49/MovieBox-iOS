//
//  SearchView.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class SearchView: BaseView {
    // TODO: Search TextField UI Design
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
        
        if let leftIcon = searchTextField.leftView as? UIImageView {
            leftIcon.tintColor = .gray1
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray2,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "영화를 검색해보세요.", attributes: attributes)
        searchTextField.textColor = .baseWhite
        searchTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        searchTextField.backgroundColor = .gray3
        searchTextField.layer.cornerRadius = 8
        searchTextField.clipsToBounds = true

        
        tableView.backgroundColor = .baseBlack
    }
    
}
