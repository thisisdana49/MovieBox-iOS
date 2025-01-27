//
//  SearchDetailView.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class SearchDetailView: BaseView {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let sectionList = ["backdrops", "Informs", "Synopsis", "Cast", "Poster"]
    let backdropSection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let castSection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let posterSection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let informView = MovieInformView()
    let synopsisView = UIView()
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = 200
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
    }
    
    func configureData(movie: Movie?) {
        informView.configureData(releaseDate: movie?.releaseDate, voteAverage: movie?.voteAverage, genre: "액션, 스릴러")
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureContentView() {
        contentView.addSubview(backdropSection)
        contentView.addSubview(informView)
        contentView.addSubview(synopsisView)
        contentView.addSubview(castSection)
        contentView.addSubview(posterSection)
        
        backdropSection.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
        
        informView.snp.makeConstraints { make in
            make.top.equalTo(backdropSection.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        synopsisView.snp.makeConstraints { make in
            make.top.equalTo(informView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        synopsisView.backgroundColor = .baseWhite
        
        castSection.snp.makeConstraints { make in
            make.top.equalTo(synopsisView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(posterSection.snp.top)
        }
        castSection.backgroundColor = .systemOrange
        
        posterSection.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        posterSection.backgroundColor = .systemBlue
        
        contentView.snp.remakeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(posterSection.snp.bottom)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        backdropSection.isPagingEnabled = true
        
        
    }

}
