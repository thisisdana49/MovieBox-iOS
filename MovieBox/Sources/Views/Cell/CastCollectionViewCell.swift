//
//  CastCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    static let id = "CastCollectionViewCell"
    
    let castImageView = UIImageView()
    let nameLabel = UILabel()
    let engNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(castImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(engNameLabel)
        
        castImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(60)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(castImageView.snp.trailing)
        }
        engNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(castImageView.snp.trailing)
        }
        
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = 30
        castImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .baseWhite
        
        engNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        engNameLabel.textColor = .gray1
    }
    // TODO: Prefetch Data
    func configureData(cast: MovieCast?) {
        if let cast, let profilePath = cast.profilePath, let castURL = URL(string: "https://image.tmdb.org/t/p/w500/\(profilePath)") {
            castImageView.kf.setImage(with: castURL)
        }
        
        nameLabel.text = cast?.name
        engNameLabel.text = cast?.originalName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
