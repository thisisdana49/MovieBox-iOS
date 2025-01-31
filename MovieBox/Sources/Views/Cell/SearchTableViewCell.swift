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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        releaseDateLabel.text = nil

        genreStackView.arrangedSubviews.forEach {
            genreStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func configureData(movie: Movie) {
        if let posterPath = movie.posterPath, let posterURL = movie.posterURL {
            posterImageView.kf.setImage(with: posterURL)
        } else {
            posterImageView.image = .noPoster
        }
        
        let genres = GenreMapper.genreNames(from: movie.genreIds)
        genres.forEach { genre in
            let label = CustomLabel()
            label.text = genre
            genreStackView.addArrangedSubview(label)
        }
        
        let releaseDate = Date.fromString(movie.releaseDate, format: "yyyy-MM-dd")
        let formattedDate = releaseDate?.toFormattedString()
        
        titleLabel.text = movie.title
        releaseDateLabel.text = formattedDate
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
            make.width.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).inset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
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
//            make.trailing.equalTo(likeButton.snp.leading)
            make.height.equalTo(25)
        }
    }
    
    func configureView() {
        backgroundColor = .baseBlack
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        
        titleLabel.textColor = .baseWhite
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        
        releaseDateLabel.textColor = .gray2
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        genreStackView.distribution = .fillProportionally
        genreStackView.spacing = 4
        
        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.mainBlue).withRenderingMode(.alwaysOriginal), for: .normal)
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
