//
//  SearchDetailTableViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import SnapKit

class SearchDetailTableViewCell: UITableViewCell {
    
    static let id = "SearchDetailTableViewCell"

    let titleLabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = .baseBlack
        return view
    }()
    let synopsisLabel = UILabel()

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    func removeTitleLabel() {
        titleLabel.removeFromSuperview()
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    func configureSynopsisLabel() {
        collectionView.removeFromSuperview()
        contentView.addSubview(synopsisLabel)
        synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(8)
        }
        synopsisLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        synopsisLabel.textColor = .baseWhite
        synopsisLabel.numberOfLines = 0
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(16)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    func configureView() {
        backgroundColor = .baseBlack
        
        titleLabel.textColor = .white
        collectionView.isPagingEnabled = true
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
