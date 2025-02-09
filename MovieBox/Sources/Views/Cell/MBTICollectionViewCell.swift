//
//  MBTICollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 2/9/25.
//

import UIKit
import SnapKit

final class MBTICollectionViewCell: UICollectionViewCell {
        
    let contentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray2.cgColor
        contentView.layer.cornerRadius = 34
        contentLabel.textAlignment = .center
    }
    // TODO: Prefetch Data
    func configureData(with text: String) {
        contentLabel.text = text
        contentLabel.textColor = .gray2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
