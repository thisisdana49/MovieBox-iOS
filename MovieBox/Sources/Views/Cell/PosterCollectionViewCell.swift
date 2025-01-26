//
//  BackdropCollectionViewCell.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let id = "PosterCollectionViewCell"
    
    let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        posterImageView.backgroundColor = .systemMint
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
