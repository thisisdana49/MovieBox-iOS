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
    var movieCredit: MovieCredit?
    var movieImage: MovieImage?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        // TODO: Movie Detail Model 만들기
        // TODO: DispatchGroup으로 만들기
        NetworkManager.shared.fetchData(apiRequest: .movieCredits(id: "545611"), requestType: MovieCredit.self) { value in
            self.movieCredit = value
            self.mainView.posterSection.reloadData()
        }
        NetworkManager.shared.fetchData(apiRequest: .movieImages(id: String(movie!.id)), requestType: MovieImage.self) { value in
            self.movieImage = value
            self.mainView.backdropSection.reloadData()
        }
        
        mainView.configureData(movie: movie)
    }
    
    func configureCollectionView() {
        mainView.backdropSection.delegate = self
        mainView.backdropSection.dataSource = self
        mainView.backdropSection.tag = 0
        mainView.backdropSection.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
        mainView.backdropSection.collectionViewLayout = backdropLayout()
        
        mainView.posterSection.delegate = self
        mainView.posterSection.dataSource = self
        mainView.posterSection.tag = 1
        mainView.posterSection.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        mainView.posterSection.collectionViewLayout = posterLayout()
        mainView.posterSection.reloadData()
    }
    
}


// MARK: CollectionView Delegate, CollectionView DataSource
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            movieImage?.backdrops.count ?? 0
        } else {
            movieImage?.posters.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
            let backdrop = movieImage?.backdrops[indexPath.item]
            cell.configureData(imagePath: backdrop?.filePath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            let poster = movieImage?.posters[indexPath.item]
            cell.configureData(imagePath: poster?.filePath)
            
            return cell
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
        layout.itemSize = CGSizeMake(cellWidth / 3.5, cellWidth / 3.5 * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
    
}
