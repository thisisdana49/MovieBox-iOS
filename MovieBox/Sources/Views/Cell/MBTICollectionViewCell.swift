//
//  MBTICollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import UIKit
import SnapKit

final class MBTICollectionViewCell: UICollectionViewCell {
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray2
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        print(#function)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        contentLabel.textAlignment = .center
        contentView.layer.cornerRadius = 34
        
        contentLabel.textColor = .gray2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray2.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.backgroundColor = .baseWhite
        contentLabel.textColor = .gray2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray2.cgColor
    }
    
    // TODO: Prefetch Data
    func configureData(with text: String) {
//        print(#function)
        contentLabel.text = text
    }
    
    func updateUI() {
//        print(#function, isSelected)
        if isSelected {
            contentView.backgroundColor = .pointBlue
            contentLabel.textColor = .baseWhite
            contentView.layer.borderWidth = 0
        } else {
            contentView.backgroundColor = .baseWhite
            contentLabel.textColor = .gray2
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.gray2.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
