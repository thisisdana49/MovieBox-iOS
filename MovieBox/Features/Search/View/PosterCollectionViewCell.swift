//
//  PosterCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import Kingfisher
import SnapKit

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
    func configureData(with image: MovieImageDetail?) {
        posterImageView.kf.setImage(with: image?.imageURL, placeholder: UIImage(named: "no_poster"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
