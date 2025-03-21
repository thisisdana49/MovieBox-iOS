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
        let keywordRemoveTapped: Observable<String> = Observable("")
        let clearAllKeywords: Observable<Void?> = Observable(nil)
        let updateRecentKeywords: Observable<Void?> = Observable(nil)
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
            self?.setupInitInformations()
        }
        
        input.keywordRemoveTapped.lazyBind { [weak self] value in
            self?.removeKeyword(at: value)
        }
        
        input.clearAllKeywords.lazyBind { [weak self] _  in
            self?.output.recentKeywords.value.removeAll()
            UserDefaultsManager.clearSearchKeywords()
        }

        input.updateRecentKeywords.lazyBind { [weak self] _  in
            print("updateRecentKeywords")
            self?.setupInitInformations()
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
    
    // TODO: 함수명 증명가능한 단위로 수정... :( 마음에 들지 않음
    private func setupInitInformations() {
        output.recentKeywords.value = UserDefaultsManager.getSearchKeywords()
        print(#function, output.recentKeywords.value)
    }
    
    private func removeKeyword(at keyword: String) {
        print(#function)
        guard let index = output.recentKeywords.value.firstIndex(of: keyword) else { return }
        output.recentKeywords.value.remove(at: index)
        UserDefaultsManager.removeSearchKeyword(keyword)
        print(UserDefaultsManager.getSearchKeywords())

    }
}
