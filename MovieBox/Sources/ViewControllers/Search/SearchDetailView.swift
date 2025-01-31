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
    let pageControl = UIPageControl()
    let castSection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let posterSection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let informView = MovieInformView()
    let synopsisView = MovieSynopsisView()
    
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
        synopsisView.configureData(content: movie?.overview ?? "")
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
        contentView.addSubview(pageControl)
        contentView.addSubview(informView)
        contentView.addSubview(synopsisView)
        contentView.addSubview(castSection)
        contentView.addSubview(posterSection)
        
        backdropSection.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(backdropSection.snp.bottom).offset(-12)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        informView.snp.makeConstraints { make in
            make.top.equalTo(backdropSection.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        synopsisView.snp.makeConstraints { make in
            make.top.equalTo(informView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(160)
        }
        
        castSection.snp.makeConstraints { make in
            make.top.equalTo(synopsisView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        castSection.backgroundColor = .baseBlack
        
        posterSection.snp.makeConstraints { make in
            make.top.equalTo(castSection.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        posterSection.backgroundColor = .baseBlack
        
        contentView.snp.remakeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(posterSection.snp.bottom)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        backdropSection.isPagingEnabled = true
        backdropSection.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray2
        pageControl.currentPageIndicatorTintColor = .gray1
    }
    
}
