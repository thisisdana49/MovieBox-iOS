//
//  CastCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit
import Kingfisher
import SnapKit

final class CastCollectionViewCell: UICollectionViewCell {
        
    let castImageView = UIImageView()
    let nameLabel = UILabel()
    let engNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    // TODO: Prefetch Data
    func configureData(cast: MovieCast?) {
        castImageView.kf.setImage(with: cast?.profileURL, placeholder: UIImage(named: "no_profile"))

        nameLabel.text = cast?.name
        engNameLabel.text = cast?.originalName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(castImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(engNameLabel)
    }
    
    private func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(55)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(castImageView.snp.centerY).offset(-4)
            make.leading.equalTo(castImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
        engNameLabel.snp.makeConstraints { make in
            make.top.equalTo(castImageView.snp.centerY).offset(4)
            make.leading.equalTo(castImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    private func configureView() {
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = 27.5
        castImageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .baseWhite
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.numberOfLines = 1
        
        engNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        engNameLabel.textColor = .gray2
        engNameLabel.lineBreakMode = .byTruncatingTail
        engNameLabel.numberOfLines = 1
    }
    
}
