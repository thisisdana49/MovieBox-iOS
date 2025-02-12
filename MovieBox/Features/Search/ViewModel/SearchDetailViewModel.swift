//
//  SearchDetailViewController.swift
//  MovieBox
//
//  Created by 조다은 on 2/12/25.
//

import UIKit

final class SearchDetailViewModel: BaseViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewDidLoad: Observable<Void?> = Observable(nil)
        // TODO: Input에서도 필요하고 Output에서도 필요하다면?
        let movie: Observable<Movie?> = Observable(nil)
    }
    
    struct Output {
        var movieCredit: MovieCredit? = nil
        var movieImage: MovieImage? = nil
        var backdropCount: Observable<Int> = Observable(0)
        let fetchSuccess: Observable<Bool> = Observable(false)
    }
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.callMovie()
        }
    }
    
    private func callMovie() {
        print(#function, input.movie.value?.id)
        guard let movieId = input.movie.value?.id else { return }
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchData(apiRequest: .movieCredits(id: "\(movieId)"), requestType: MovieCredit.self) { [weak self] value in
            self?.output.movieCredit = value
            group.leave()
        } failureHandler: { error in
            print("네트워크 오류", error.localizedDescription)
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.fetchData(apiRequest: .movieImages(id: "\(movieId)"), requestType: MovieImage.self) { [weak self] value in
            self?.output.movieImage = value
            group.leave()
        } failureHandler: { error in
            print("네트워크 오류", error.localizedDescription)
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.output.fetchSuccess.value = true

            if let backdropCount = self?.output.movieImage?.backdrops.prefix(5).count {
                self?.output.backdropCount.value = backdropCount
            }
        }
    }
    
}
