//
//  SearchViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/11/25.
//

import Foundation

final class SearchViewModel: BaseViewModel  {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let isFromMainView: Observable<Void?> = Observable(nil)
        let searchTextField: Observable<String?> = Observable("")
        let prefetchRows: Observable<[IndexPath]> = Observable([])
        // TODO: Search VM의 입장에서 네이밍 필요
        let keywordTapped: Observable<String> = Observable("")
    }
    
    struct Output {
        let searchBarFocus: Observable<Bool> = Observable(false)
        let scrollToTop: Observable<Void?> = Observable(nil)
        let searchResultMovies: Observable<[Movie]> = Observable([])
        let isNoResult: Observable<Bool>  = Observable(false)
        let recentKeywords: Observable<[String]> = Observable([])
    }
    
    var searchWord: String = "" {
        didSet { page = 1 }
    }
    var page: Int = 1 {
        didSet { isEnd = page == totalPages }
    }
    var totalPages = 0
    var isEnd = false
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.isFromMainView.lazyBind { [weak self] _ in
            self?.output.searchBarFocus.value = true
        }
        
        input.searchTextField.lazyBind { [weak self] value in
            if let inputValue = value {
                self?.searchWord = inputValue
                self?.didSearchKeyword(with: inputValue)
                self?.callMovies()
            }
        }
        
        input.prefetchRows.lazyBind { [weak self] value in
            self?.prefetchingData(at: value)
        }
        
        input.keywordTapped.lazyBind { [weak self] value in
            self?.searchWord = value
            self?.callMovies()
        }
        
    }
 
    private func callMovies() {
        print(#function, page, isEnd, totalPages)

        NetworkManager.shared.fetchData(apiRequest: .searchMovies(keyword: searchWord, page: page), requestType: MovieListResponse.self) { value in
            if self.page == 1 {
                self.output.searchResultMovies.value.removeAll()
                if value.totalResults == 0 {
                    self.output.isNoResult.value = true
                } else {
                    self.output.isNoResult.value = false
                    self.totalPages = value.totalPages
                    self.output.searchResultMovies.value = value.results
                    self.output.scrollToTop.value = ()
                    print("input scroll to top")
                }
            } else {
                self.output.searchResultMovies.value.append(contentsOf: value.results)
            }

        }
        failureHandler: { error in
            print("네트워크 오류", error.localizedDescription)
        }
    }
    
    private func prefetchingData(at indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if (output.searchResultMovies.value.count - 2) == indexPath.row && !isEnd {
                page += 1
                callMovies()
            }
        }
    }
    
    private func didSearchKeyword(with keyword: String) {
        if !output.recentKeywords.value.contains(keyword) {
            UserDefaultsManager.saveSearchKeyword(keyword)
            output.recentKeywords.value.insert(keyword, at: 0)
            print("최근 검색어: \(output.recentKeywords.value)")
        }
        
        NotificationCenter.default.post(
            name: NSNotification.Name("ReceiveKeywordSearch"),
            object: nil
        )
    }
    
}
