//
//  BackdropCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import Kingfisher

final class BackdropCollectionViewCell: UICollectionViewCell {
        
    let backdropImageView = UIImageView()
    // TODO: Indicators 추가
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backdropImageView)
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backdropImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(imagePath: String?) {
        if let imagePath {
            let backdropURL = URL(string: "https://image.tmdb.org/t/p/original/\(imagePath)")
            backdropImageView.kf.setImage(with: backdropURL)
        } else {
            backdropImageView.image = .noBackdrop
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
