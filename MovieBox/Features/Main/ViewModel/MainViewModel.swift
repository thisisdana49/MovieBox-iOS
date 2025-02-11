//
//  MainViewModel.swift
//  MovieBox
//
//  Created by 조다은 on 2/11/25.
//

import Foundation

final class MainViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        var todaysMovies: [Movie] = []
        let recentKeywords: Observable<[String]> = Observable([])
        let fetchSuccess: Observable<Bool> = Observable(false)
    }
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.callTrendingMovies()
        }
    }
    
    private func callTrendingMovies() {
        NetworkManager.shared.fetchData(
            apiRequest: .trendingMovies,
            requestType: MovieListResponse.self,
            successHandler: { [weak self] value in
                self?.output.todaysMovies = value.results
                self?.output.fetchSuccess.value = true
            },
            failureHandler: { error in
                print("네트워크 오류", error.localizedDescription)
            }
        )
    }
    
}
