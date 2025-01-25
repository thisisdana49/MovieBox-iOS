//
//  MainCollectionViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
//    static let id = "MainCollectionViewCell"
    static var id: String {
        String(describing: self)
    }
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let likeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    func configureData(poster: String, title: String, overview: String) {
        let posterURL = "https://image.tmdb.org/t/p/original/\(poster)"
        if let imageURL = URL(string: posterURL) {
            posterImageView.kf.setImage(with: imageURL)
        }
        titleLabel.text = title
        overviewLabel.text = overview
    }
    
    func configureHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(likeButton)
        addSubview(overviewLabel)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom)
            make.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureView() {
        posterImageView.image = UIImage(systemName: "star.fill")
        posterImageView.layer.cornerRadius = 15
        posterImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .baseWhite
        
        overviewLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        overviewLabel.textColor = .gray1
        overviewLabel.numberOfLines = 2
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
