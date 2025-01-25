//
//  MainTableViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class RecentKeywordTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }

    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .baseBlack
        
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        titleLabel.textColor = .baseWhite
    }
    
    func configureData(keywords: [String]) {
        for keyword in keywords {
            let button = CustomKeywordButton(title: keyword)
            stackView.addArrangedSubview(button)
        }
        
        stackView.subviews.forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(stackView.snp.height).inset(12)
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
