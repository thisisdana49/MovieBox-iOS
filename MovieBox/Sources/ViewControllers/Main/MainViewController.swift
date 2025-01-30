//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
//    let recentKeywords: [String] = []
    var recentKeywords: [String] = ["해리포터", "이제훈", "슬램덩크더퍼스트", "위니더푸"]
    let buttonAction = UIAction(title: "버튼", image: UIImage(systemName: "heart")) { value in
        print("클릭됨~", value)
    }
    var todaysMovies: [Movie] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(apiRequest: .trendingMovies, requestType: MovieListResponse.self) { value in
            self.todaysMovies = value.results
            self.mainView.todaysMovieSection.collectionView.reloadData()
        }
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.recentKeywordsView.keywordButtons.forEach { button in
            button.addTarget(self, action: #selector(keywordButtonTapped), for: .touchUpInside)
        }
    }
    
    func configureView() {
        navigationItem.title = "MovieBox"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
        mainView.todaysMovieSection.collectionView.delegate = self
        mainView.todaysMovieSection.collectionView.dataSource = self
        mainView.todaysMovieSection.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
    @objc
    func searchButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc
    func keywordButtonTapped(_ sender: CustomKeywordButton) {
        print(sender.name)
        let vc = SearchViewController()
        vc.searchWord = sender.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: CollectionView Delegate, CollectionView DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        
        let movie = todaysMovies[indexPath.row]
        
        cell.configureData(poster: movie.posterPath ?? "", title: movie.title, overview: movie.overview)
        
        return cell
    }
    
}
