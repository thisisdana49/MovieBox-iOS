//
//  SearchViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class SearchViewController: UIViewController {

    var passDelegate: SearchKeywordPassDelegate?
    var isFromMainView: Bool = false

    let mainView = SearchView()
    
    var movies: [Movie] = []
    var searchWord: String = "" {
        didSet {
            page = 1
            callRequest()
        }
    }
    private var page = 1 {
        didSet {
            isEnd = page == totalPages
        }
    }
    private var totalPages = 0
    private var isEnd = false
    var isNoResult = false
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        callRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFromMainView {
            mainView.searchTextField.becomeFirstResponder()
        }
    }
    
    fileprivate func callRequest() {
        NetworkManager.shared.fetchData(apiRequest: .searchMovies(keyword: searchWord, page: page), requestType: MovieListResponse.self) { value in
            if self.page == 1 {
                if value.totalResults == 0 {
                    self.isNoResult = true
                } else {
                    self.isNoResult = false
                    self.movies = value.results
                }
            } else {
                self.movies.append(contentsOf: value.results)
            }
            self.mainView.tableView.reloadData()
            
            if self.page == 1 {
                self.mainView.tableView.scrollsToTop = true
            }
        }
    }

    func configureView() {
        navigationItem.title = "영화 검색"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        mainView.searchTextField.delegate = self
        mainView.searchTextField.text = searchWord
    }
}


// MARK: SearchTextField Delegate
extension SearchViewController: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let inputText = textField.text else { return true }
        searchWord = inputText
        passDelegate?.didSearchKeyword(inputText)
        return true
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
        
        cell.configureData(movie)
        
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


// MARK: TableView DataSource Prefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
    // TODO: cancel previous perform request
//    override class func cancelPreviousPerformRequests(withTarget aTarget: Any) {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        print(#function)
        for indexPath in indexPaths {
            if (movies.count - 2) == indexPath.row && !isEnd {
                page += 1
                callRequest()
            }
        }
    }
    
}
