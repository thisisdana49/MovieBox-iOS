//
//  MovieInformView.swift
//  MovieBox
//
//  Created by 조다은 on 1/27/25.
//

import UIKit

class MovieInformView: BaseView {

    let calendarSymbol = NSTextAttachment()
    let starSymbol = NSTextAttachment()
    let filmSymbol = NSTextAttachment()
    let informsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureData(releaseDate: String?, voteAverage: Double?, genre: String) {
        guard let releaseDate, let voteAverage else { return }
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: calendarSymbol))
        fullString.append(NSAttributedString(string: "  \(releaseDate)  |  "))
        fullString.append(NSAttributedString(attachment: starSymbol))
        fullString.append(NSAttributedString(string: "  \(voteAverage)  |  "))
        fullString.append(NSAttributedString(attachment: filmSymbol))
        fullString.append(NSAttributedString(string: "  \(genre)"))
        informsLabel.attributedText = fullString
    }
    
    override func configureHierarchy() {
        addSubview(informsLabel)
    }

    override func configureLayout() {
        informsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        calendarSymbol.image = UIImage(systemName: "calendar")?.withTintColor(.gray2)
        calendarSymbol.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)
        starSymbol.image = UIImage(systemName: "star.fill")?.withTintColor(.gray2)
        starSymbol.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)
        filmSymbol.image = UIImage(systemName: "film.fill")?.withTintColor(.gray2)
        filmSymbol.bounds = CGRect(x: 0, y: -2, width: 15, height: 15)
        
        informsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        informsLabel.textColor = .gray2
        informsLabel.textAlignment = .center
    }
    
}
