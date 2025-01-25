//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    let recentKeywords: [String] = ["해리포터", "이제훈", "슬램덩크더퍼스트", "위니더푸"]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(apiRequest: .trendingMovies, requestType: MovieListResponse.self)
        
        configureTableview()
    }
    
    func configureTableview() {
        mainView.movieTableView.delegate = self
        mainView.movieTableView.dataSource = self
        mainView.movieTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
    }
    
}


// MARK: TableView Delegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as! MainTableViewCell

            cell.titleLabel.text = "오늘의 영화"
            return cell
    }
    
}


// MARK:
//extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//        
//        return cell
//    }
//    
//}
