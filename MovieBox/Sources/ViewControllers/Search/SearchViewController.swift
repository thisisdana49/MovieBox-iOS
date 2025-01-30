//
//  SearchViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

class SearchViewController: UIViewController {

    let mainView = SearchView()
    
    var movies: [Movie] = []
    var searchWord: String = ""
    var isNoResult = false
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        callRequest()
    }
    
    fileprivate func callRequest() {
        NetworkManager.shared.fetchData(apiRequest: .searchMovies(keyword: searchWord), requestType: MovieListResponse.self) { value in
            if value.totalResults == 0 {
                self.isNoResult = true
                self.mainView.tableView.reloadData()
            } else {
                self.isNoResult = false
                self.movies = value.results
                self.mainView.tableView.reloadData()
            }
        }
    }

    func configureView() {
        navigationItem.title = "영화 검색"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        mainView.searchTextField.text = searchWord
    }
}


// MARK: TableView Delegate, TableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNoResult && searchWord != "" {
            tableView.setEmptyMessage("원하는 검색결과를 찾지 못했습니다.")
        } else {
            tableView.restore()
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        let movie = movies[indexPath.row]
        
        cell.posterImageView.backgroundColor = .yellow
        cell.genreStackView.backgroundColor = .systemPink
        cell.configureData(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SearchDetailViewController()
        vc.movie = movies[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
