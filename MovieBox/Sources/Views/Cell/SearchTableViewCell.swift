//
//  SearchTableViewCell.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let id = "SearchTableViewCell"
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let genreStackView = UIStackView()
    let genreLabel = UILabel()
    let likeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    func configureData(movie: Movie) {
        let posterURL = "https://image.tmdb.org/t/p/original/\(movie.posterPath ?? "")"
        if let imageURL = URL(string: posterURL) {
            posterImageView.kf.setImage(with: imageURL)
        }
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
    
    func configureHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genreStackView)
        addSubview(likeButton)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.size.equalTo(30)
        }
        
        genreStackView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalTo(likeButton.snp.leading)
            make.height.equalTo(30)
        }
    }
    
    func configureView() {
        backgroundColor = .baseBlack
        
        posterImageView.image = UIImage(systemName: "star")
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        
        titleLabel.textColor = .baseWhite
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        releaseDateLabel.textColor = .gray1
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
