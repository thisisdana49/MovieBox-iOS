//
//  PosterCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class PosterCollectionViewCell: UICollectionViewCell {
        
    let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    // TODO: Prefetch Data
    func configureData(imagePath: String?) {
        if let imagePath, let posterURL = URL(string: "https://image.tmdb.org/t/p/original/\(imagePath)") {
            posterImageView.kf.setImage(with: posterURL)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
