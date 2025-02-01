//
//  RecentKeywordSectionView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import SnapKit

final class RecentKeywordSectionView: BaseView {
    
    let headerLabel = UILabel()
    let deleteButton = UIButton()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let emptyLabel = UILabel()
    var keywordButtons: [CustomKeywordButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureData(keywords: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        keywordButtons.removeAll()
        
        if keywords.isEmpty {
            deleteButton.isHidden = true
            emptyLabel.isHidden = false
            stackView.isHidden = true
        } else {
            deleteButton.isHidden = false
            stackView.isHidden = false
            emptyLabel.isHidden = true
            
            for keyword in keywords {
                let button = CustomKeywordButton(title: keyword)
                stackView.addArrangedSubview(button)
                keywordButtons.append(button)
            }
            
            stackView.arrangedSubviews.forEach { button in
                button.snp.makeConstraints { make in
                    make.height.equalTo(stackView.snp.height).inset(8)
                }
            }
        }
    }
    
    override func configureHierarchy() {
        addSubview(headerLabel)
        addSubview(deleteButton)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        headerLabel.textColor = .baseWhite
        
        deleteButton.setTitle("전체 삭제", for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        deleteButton.setTitleColor(.mainBlue, for: .normal)
        deleteButton.isHidden = true
        
        emptyLabel.text = "최근 검색어 내역이 없습니다."
        emptyLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        emptyLabel.textColor = .gray2
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true
    }
    
}
