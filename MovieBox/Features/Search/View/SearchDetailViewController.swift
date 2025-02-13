//
//  SearchDetailViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class SearchDetailViewController: UIViewController {
    
    let viewModel = SearchDetailViewModel()
    let mainView = SearchDetailView()
    
    init(movie: Movie) {
        self.viewModel.input.movie.value = movie
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.fetchSuccess.bind { [weak self] _ in
            self?.mainView.configureData(movie: self?.viewModel.input.movie.value)
            self?.setupView(with: self?.viewModel.input.movie.value)
            self?.mainView.castSection.reloadData()
            self?.mainView.posterSection.reloadData()
            self?.mainView.backdropSection.reloadData()
        }
        
        viewModel.output.backdropCount.bind { [weak self] value in
            self?.mainView.pageControl.numberOfPages = value
            self?.mainView.pageControl.isHidden = (value == 0)
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
    
    private func setupView(with movie: Movie?) {
        guard let movie = movie else { return }
        var likeButton = CustomLikeButton()

        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        likeButton.setMovieID(movie.id)

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
            let backdropCount = viewModel.output.movieImage?.backdrops.count ?? 0
            return min(5, max(1, backdropCount))
        }
        else if collectionView.tag == 1 {
            if viewModel.output.movieCredit?.cast.count == 0 {
                collectionView.setEmptyMessage("출연진 정보가 없는 영화입니다.")
            }
            else {
                collectionView.restore()
            }
            return viewModel.output.movieCredit?.cast.count ?? 0
        }
        else {
            if viewModel.output.movieImage?.posters.count == 0 {
                collectionView.setEmptyMessage("포스터 이미지가 없는 영화입니다.")
            }
            else {
                collectionView.restore()
            }
            return viewModel.output.movieImage?.posters.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as? BackdropCollectionViewCell else { return UICollectionViewCell() }
            let backdrops = viewModel.output.movieImage?.backdrops.prefix(5)
            if backdrops?.isEmpty ?? true {
                cell.configureData(with: nil)
            } else {
                let backdrop = backdrops?[indexPath.item]
                cell.configureData(with: backdrop)
            }
            
            return cell
        }
        
        else if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            let cast = viewModel.output.movieCredit?.cast[indexPath.item]
            cell.configureData(cast: cast)
            return cell
        }
        
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
            let poster = viewModel.output.movieImage?.posters[indexPath.item]
            cell.configureData(with: poster)
            
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
