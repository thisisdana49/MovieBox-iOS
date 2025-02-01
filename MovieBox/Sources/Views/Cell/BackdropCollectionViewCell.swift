//
//  BackdropCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import Kingfisher
import SnapKit

final class BackdropCollectionViewCell: UICollectionViewCell {
        
    let backdropImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backdropImageView)
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backdropImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(with image: MovieImageDetail?) {
        backdropImageView.kf.setImage(with: image?.imageURL, placeholder: UIImage(named: "no_backdrop"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
