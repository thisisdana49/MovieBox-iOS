//
//  SearchDetailViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class SearchDetailViewController: UIViewController {
    
    let mainView = SearchDetailView()
    var movie: Movie?
    var likeButton = CustomLikeButton()
    var movieCredit: MovieCredit?
    var movieImage: MovieImage?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchMovieData()
    }
    
    // TODO: Movie Detail Model 만들기
    private func fetchMovieData() {
        guard let movie = movie else { return }
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchData(apiRequest: .movieCredits(id: "\(movie.id)"), requestType: MovieCredit.self) { [weak self] value in
            self?.movieCredit = value
            group.leave()
        } failureHandler: { error in
            print("네트워크 오류", error.localizedDescription)
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.fetchData(apiRequest: .movieImages(id: "\(movie.id)"), requestType: MovieImage.self) { [weak self] value in
            self?.movieImage = value
            group.leave()
        } failureHandler: { error in
            print("네트워크 오류", error.localizedDescription)
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.mainView.castSection.reloadData()
            self?.mainView.posterSection.reloadData()
            self?.mainView.backdropSection.reloadData()
            
            if let backdropCount = self?.movieImage?.backdrops.prefix(5).count {
                self?.mainView.pageControl.numberOfPages = backdropCount
                self?.mainView.pageControl.isHidden = (backdropCount == 0)
            }
        }
    }
    
    @objc
    private func toggleSynopsisHeight(_ notification: Notification) {
        guard let newHeight = notification.object as? CGFloat else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.synopsisView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        guard let movie = movie else { return }
        
        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        likeButton.setMovieID(movie.id)
        
        mainView.configureData(movie: movie)
        configureCollectionView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(toggleSynopsisHeight),
            name: NSNotification.Name("ToggleSynopsisHeight"),
            object: nil
        )
    }
    
    private func configureCollectionView() {
        mainView.backdropSection.delegate = self
        mainView.backdropSection.dataSource = self
        mainView.backdropSection.tag = 0
        mainView.backdropSection.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
        mainView.backdropSection.collectionViewLayout = backdropLayout()
        
        mainView.castSection.delegate = self
        mainView.castSection.dataSource = self
        mainView.castSection.tag = 1
        mainView.castSection.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
        mainView.castSection.collectionViewLayout = castLayout()
        
        mainView.posterSection.delegate = self
        mainView.posterSection.dataSource = self
        mainView.posterSection.tag = 2
        mainView.posterSection.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        mainView.posterSection.collectionViewLayout = posterLayout()
    }
    
}


// MARK: CollectionView Delegate, CollectionView DataSource
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            let backdropCount = movieImage?.backdrops.count ?? 0
            return min(5, max(1, backdropCount))
        }
        else if collectionView.tag == 1 {
            if movieCredit?.cast.count == 0 {
                collectionView.setEmptyMessage("출연진 정보가 없는 영화입니다.")
            }
            else {
                collectionView.restore()
            }
            return movieCredit?.cast.count ?? 0
        }
        else {
            if movieImage?.posters.count == 0 {
                collectionView.setEmptyMessage("포스터 이미지가 없는 영화입니다.")
            }
            else {
                collectionView.restore()
            }
            return movieImage?.posters.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
            let backdrops = movieImage?.backdrops.prefix(5)
            if backdrops?.isEmpty ?? true {
                cell.configureData(imagePath: nil)
            } else {
                let backdrop = backdrops?[indexPath.item]
                cell.configureData(imagePath: backdrop?.filePath)
            }
            
            return cell
        }
        
        else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as! CastCollectionViewCell
            let cast = movieCredit?.cast[indexPath.item]
            cell.configureData(cast: cast)
            print(self, #function)
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            let poster = movieImage?.posters[indexPath.item]
            cell.configureData(imagePath: poster?.filePath)
            
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainView.backdropSection {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            mainView.pageControl.currentPage = pageIndex
        }
    }
    
    private func backdropLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 0
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(cellWidth, cellWidth * 0.7)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        return layout
    }
    
    private func posterLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 8
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (spacing * 4)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSizeMake(cellWidth / 3.5, cellWidth / 3.5 * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
    
    private func castLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 12
        let spacing: CGFloat = 12
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (spacing * 2) - (sectionInset)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(cellWidth / 2.2, 50)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: sectionInset, bottom: spacing, right: sectionInset)
        return layout
    }
}
