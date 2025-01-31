//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    let mainView = MainView()
    var recentKeywords: [String] = []
//    var recentKeywords: [String] = ["해리포터", "이제훈", "슬램덩크더퍼스트", "위니더푸"]
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView),
            name: NSNotification.Name("ReloadLikedButtons"),
            object: nil
        )
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recentKeywords = UserDefaultsManager.getSearchKeywords()
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
        mainView.recentKeywordsView.keywordButtons.forEach { button in
            button.addTarget(self, action: #selector(keywordButtonTapped), for: .touchUpInside)
        }
        
        mainView.profileSection.updateUserInfo()
    }
    
    @objc
    private func reloadCollectionView() {
        mainView.todaysMovieSection.collectionView.reloadData()
//        print(#function)
    }
    
    func configureView() {
        navigationItem.title = "MovieBox"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        mainView.recentKeywordsView.deleteButton.addTarget(self, action: #selector(clearAllKeywords), for: .touchUpInside)
        
        mainView.todaysMovieSection.collectionView.delegate = self
        mainView.todaysMovieSection.collectionView.dataSource = self
        mainView.todaysMovieSection.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
    @objc
    func searchButtonTapped(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
        vc.passDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func keywordButtonTapped(_ sender: CustomKeywordButton) {
        // TODO: 선택 시 순서 변경 되도록 구현
        let vc = SearchViewController()
        vc.searchWord = sender.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func clearAllKeywords() {
        recentKeywords.removeAll()
        
        UserDefaultsManager.clearSearchKeywords()

        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
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
        // TODO: 전달용 model 구성
        cell.configureData(movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchDetailViewController()
        vc.movie = todaysMovies[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: Pass Delegate
extension MainViewController: PassDataDelegate {
    
    func didSearchKeyword(_ keyword: String) {
        if !recentKeywords.contains(keyword) {
            recentKeywords.insert(keyword, at: 0)
        }
        print("최근 검색어: \(recentKeywords)")
        UserDefaultsManager.saveSearchKeyword(keyword)
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
    }
    
}
