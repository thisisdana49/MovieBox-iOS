//
//  MainViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/24/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    let mainView = MainView()
    var recentKeywords: [String] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNotifications()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRecentKeywords()
        mainView.profileSection.updateUserInfo()
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.fetchSuccess.lazyBind { [weak self] _ in
            self?.mainView.todaysMovieSection.collectionView.reloadData()
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView),
            name: NSNotification.Name("ReloadLikedButtons"),
            object: nil
        )
    }
    
    private func updateRecentKeywords() {
        recentKeywords = UserDefaultsManager.getSearchKeywords()
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)

        mainView.recentKeywordsView.keywordButtons.forEach { button in
            // TODO: weak self 다시 한번 복습
            button.onKeywordTapped = { [weak self] in
                self?.keywordButtonTapped(button)
            }
            button.onXmarkTapped = { [weak self] in
                self?.removeKeyword(button)
            }
        }
    }
    
    private func setupView() {
        configureNavigationBar()
        configureView()
    }
    
    private func configureView() {
        navigationItem.title = "MovieBox"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        // TODO: Noti로 구성?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileInformViewTapped))
        mainView.profileSection.addGestureRecognizer(tapGesture)
        mainView.profileSection.isUserInteractionEnabled = true
        
        mainView.recentKeywordsView.deleteButton.addTarget(self, action: #selector(clearAllKeywords), for: .touchUpInside)
        
        mainView.todaysMovieSection.collectionView.delegate = self
        mainView.todaysMovieSection.collectionView.dataSource = self
        mainView.todaysMovieSection.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
    
    private func configureNavigationBar() {
        navigationItem.title = "MovieBox"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
    
    @objc
    private func reloadCollectionView() {
        mainView.todaysMovieSection.collectionView.reloadData()
        mainView.profileSection.updateUserInfo()
    }
    
    @objc
    func searchButtonTapped(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
        vc.passDelegate = self
        vc.viewModel.input.isFromMainView.value = ()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func profileInformViewTapped() {
        let currentNickname = UserDefaultsManager.get(forKey: .userNickname) as? String ?? "사용자"
        let vc = ProfileSettingViewController()
        vc.passDelegate = self
        vc.mode = .edit(currentNickname: currentNickname)
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true)
    }
    
    @objc
    func clearAllKeywords() {
        recentKeywords.removeAll()
        
        UserDefaultsManager.clearSearchKeywords()
        
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
    }
    
    @objc
    func keywordButtonTapped(_ sender: CustomKeywordButton) {
        // TODO: 선택 시 순서 변경 되도록 구현
        print(#function)
        let vc = SearchViewController()
        vc.searchWord = sender.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func removeKeyword(_ button: CustomKeywordButton) {
        guard let index = recentKeywords.firstIndex(of: button.name) else { return }
        recentKeywords.remove(at: index)
        UserDefaultsManager.removeSearchKeyword(button.name)
        print(#function)
        print(recentKeywords)
        print(UserDefaultsManager.getSearchKeywords())
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
        updateRecentKeywords()
    }
    
}


// MARK: CollectionView Delegate, CollectionView DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.todaysMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = viewModel.output.todaysMovies[indexPath.row]
        // TODO: 전달용 model 구성
        cell.configureData(movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SearchDetailViewController()
        vc.movie = viewModel.output.todaysMovies[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: Pass Delegate
extension MainViewController: SearchKeywordPassDelegate,ProfileSettingPassDelegate {
    
    func didSearchKeyword(_ keyword: String) {
        if !recentKeywords.contains(keyword) {
            recentKeywords.insert(keyword, at: 0)
        }
        print("최근 검색어: \(recentKeywords)")
        UserDefaultsManager.saveSearchKeyword(keyword)
        mainView.recentKeywordsView.configureData(keywords: recentKeywords)
    }
    
    func didUpdateProfile() {
        mainView.profileSection.updateUserInfo()
    }
    
}
