//
//  RecentKeywordSectionView.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import SnapKit

class RecentKeywordSectionView: BaseView {
    
    let headerLabel = UILabel()
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
            emptyLabel.isHidden = false
            stackView.isHidden = true
        } else {
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
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
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
        
        emptyLabel.text = "최근 검색어 내역이 없습니다."
        emptyLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        emptyLabel.textColor = .gray1
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true
        
        scrollView.backgroundColor = .yellow
        stackView.backgroundColor = .systemPink
    }
    
}
