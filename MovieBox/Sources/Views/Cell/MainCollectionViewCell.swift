//
//  MainCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import Kingfisher

final class MainCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let likeButton = CustomLikeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    func configureData(_ movie: Movie) {
        if let posterPath = movie.posterPath, let posterURL = movie.posterURL {
            posterImageView.kf.setImage(with: posterURL)
        } else {
            posterImageView.image = .noPoster
        }
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        likeButton.setMovieID(movie.id)
    }
    
    func configureHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(likeButton)
        addSubview(overviewLabel)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(6)
            make.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(4)
            make.trailing.equalToSuperview()
            make.size.equalTo(25)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureView() {
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .baseWhite
        
        overviewLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        overviewLabel.textColor = .gray1
        overviewLabel.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
