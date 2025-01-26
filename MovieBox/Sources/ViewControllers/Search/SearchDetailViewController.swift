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
    let sections = ["backdrops", "synopsis", "cast", "poster", "poster"]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        // TODO: Movie Detail Model 만들기
        // TODO: DispatchGroup으로 만들기
        NetworkManager.shared.fetchData(apiRequest: .movieCredits(id: "545611"), requestType: MovieCredit.self) { value in
            self.movieCredit = value
//            dump(self.movieCredit)
        }
        NetworkManager.shared.fetchData(apiRequest: .movieImages(id: String(movie!.id)), requestType: MovieImage.self) { value in
            self.movieImage = value
            self.mainView.tableView.reloadData()
//            dump(self.movieImage)
        }
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchDetailTableViewCell.self, forCellReuseIdentifier: SearchDetailTableViewCell.id)
    }
    
}


// MARK: TableView Delegate, TableView DataSource
extension SearchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewCell.id, for: indexPath) as! SearchDetailTableViewCell
        
        cell.titleLabel.text = sections[indexPath.row]
        // Backdrops Section
        if indexPath.row == 0 {
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row
            cell.collectionView.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
            cell.collectionView.collectionViewLayout = SearchDetailViewController.backdropLayout()
            cell.removeTitleLabel()
            cell.collectionView.reloadData()
        }
        // Synopsis Section
        else if indexPath.row == 1 {
            cell.configureSynopsisLabel()
            cell.synopsisLabel.text = movie?.overview
        }
        // Cast Section
        else if indexPath.row == 2 {
//            cell.configureSynopsisLabel()
//            cell.synopsisLabel.text = movie?.overview
        }
        // Poster Section
        else if indexPath.row == 3 {
//            cell.configureSynopsisLabel()
//            cell.synopsisLabel.text = movie?.overview
        }
        // Synopsis Section
        else {
//            cell.configureSynopsisLabel()
//            cell.synopsisLabel.text = movie?.overview
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // TODO: 유동적으로 크기 설정
            return 270
        }
        else if indexPath.row == 1 {
            return 180
        }
        else if indexPath.row == 2 {
            return 180
        }
        else if indexPath.row == 3 {
            return 180
        }
        else { return 180 }
    }
    
}

// MARK: CollectionView Delegate, CollectionView DataSource
extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImage?.backdrops.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
        let backdrop = movieImage?.backdrops[indexPath.item]
        cell.configureData(imagePath: backdrop?.filePath)
        
        return cell
    }
    
    static private func backdropLayout() -> UICollectionViewLayout {
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
}


