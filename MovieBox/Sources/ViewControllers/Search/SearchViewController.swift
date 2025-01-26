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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(apiRequest: .searchMovies(keyword: "all at once"), requestType: MovieListResponse.self) { value in
            self.movies = value.results
            self.mainView.tableView.reloadData()
        }
        
        configureView()
    }

    func configureView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
}


// MARK: TableView Delegate, TableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
