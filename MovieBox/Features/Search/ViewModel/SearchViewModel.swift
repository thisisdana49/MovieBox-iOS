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
    }
    
    struct Output {
        let searchBarFocus: Observable<Bool> = Observable(false)
        let scrollToTop: Observable<Void?> = Observable(nil)
        let searchResultMovies: Observable<[Movie]> = Observable([])
    }
    
    var searchWord: String = "" {
        didSet { page = 1 }
    }
    var isNoResult: Bool = false
    var page: Int = 1
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.isFromMainView.lazyBind { [weak self] _ in
            print("isFromMainView")
            self?.output.searchBarFocus.value = true
        }
        
        input.searchTextField.lazyBind { [weak self] value in
            if let inputValue = value {
                self?.searchWord = inputValue
                self?.callMovies()
            }
        }
    }
 
    private func callMovies() {
        NetworkManager.shared.fetchData(apiRequest: .searchMovies(keyword: searchWord, page: page), requestType: MovieListResponse.self) { value in
            if self.page == 1 {
                if value.totalResults == 0 {
                    self.isNoResult = true
                } else {
                    self.isNoResult = false
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
}
