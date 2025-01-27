//
//  MovieSynopsisView.swift
//  MovieBox
//
//  Created by 조다은 on 1/27/25.
//

import UIKit

class MovieSynopsisView: BaseView {

    let headerLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureData(content: String) {
        contentLabel.text = content
    }
    
    override func configureHierarchy() {
        addSubview(headerLabel)
        addSubview(contentLabel)
    }

    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(12)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    override func configureView() {
        headerLabel.text = "Synopsis"
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        headerLabel.textColor = .white
        
        contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentLabel.textColor = .gray1
        contentLabel.textAlignment = .justified
        contentLabel.numberOfLines = 0
    }
    
}
