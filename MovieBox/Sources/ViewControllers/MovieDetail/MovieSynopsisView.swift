//
//  MovieSynopsisView.swift
//  MovieBox
//
//  Created by 조다은 on 1/27/25.
//

import UIKit
import SnapKit

final class MovieSynopsisView: BaseView {
    
    var isExpanded = false {
        didSet {
            updateContent()
        }
    }
    let lineHeight: CGFloat = 20
    
    let headerLabel = UILabel()
    let moreButton = UIButton()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func moreButtonTapped() {
        isExpanded.toggle()
        
        let newHeight = calculateContentHeight(expanded: isExpanded)
        NotificationCenter.default.post(
            name: NSNotification.Name("ToggleSynopsisHeight"),
            object: newHeight)
        
    }
    
    func configureData(content: String) {
        if content.isEmpty {
            contentLabel.text = "\n줄거리 정보가 없는 영화입니다."
            contentLabel.textAlignment = .center
            moreButton.isHidden = true
            return
        }
        
        contentLabel.text = content
        layoutIfNeeded()
        
        let totalLines = contentLabel.calculateNumberOfLines()
        print(#function, totalLines)
        moreButton.isHidden = totalLines <= 3
    }
    
    func calculateContentHeight(expanded: Bool) -> CGFloat {
        let maxLines = expanded ? contentLabel.calculateNumberOfLines() : 3
        return CGFloat(maxLines) * lineHeight + 40
    }
    
    // TODO: synopsis 없을 때 처리
    func updateContent() {
        contentLabel.numberOfLines = isExpanded ? 0 : 3
        moreButton.setTitle(isExpanded ? "Hide" : "More", for: .normal)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8) {
            self.layoutIfNeeded()
        }
    }
    
    override func configureHierarchy() {
        addSubview(headerLabel)
        addSubview(moreButton)
        addSubview(contentLabel)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    override func configureView() {
        headerLabel.text = "Synopsis"
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        headerLabel.textColor = .baseWhite
        
        moreButton.setTitle("More", for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        moreButton.setTitleColor(.mainBlue, for: .normal)
        
        contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        contentLabel.textColor = .gray1
        contentLabel.textAlignment = .justified
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.numberOfLines = 3
    }
    
}
