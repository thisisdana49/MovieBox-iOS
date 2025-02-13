//
//  SearchViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/26/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let viewModel = SearchViewModel()
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindData()
    }
    
    // TODO: 어떤 위치로? 혹은 다른 로직으로 고민해보기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.searchBarFocus.bind { [weak self] value in
            if value { self?.mainView.searchTextField.becomeFirstResponder() }
        }
        
        viewModel.output.scrollToTop.lazyBind { [weak self] _ in
            print("output scroll to top")
            self?.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        viewModel.output.searchResultMovies.lazyBind { [weak self] _ in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.output.tableViewStatus.lazyBind { [weak self] value in
            self?.mainView.tableView.setEmptyMessage(value)
        }
    }
    
    private func setupView() {
        navigationItem.title = "영화 검색"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        mainView.searchTextField.delegate = self
    }

}


// MARK: SearchTextField Delegate
extension SearchViewController: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.input.searchTextField.value = textField.text
        return true
    }
    
}


// MARK: TableView Delegate, TableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.searchResultMovies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let movie = viewModel.output.searchResultMovies.value[indexPath.row]
        
        cell.configureData(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.output.searchResultMovies.value[indexPath.row]
        let vc = SearchDetailViewController(movie: movie)
        
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
        viewModel.input.prefetchRows.value = indexPaths
    }
    
}
