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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        updateRecentKeywords()
        mainView.profileSection.updateUserInfo()
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.fetchSuccess.lazyBind { [weak self] _ in
            self?.mainView.todaysMovieSection.collectionView.reloadData()
        }
        // TODO: lazy bind가 되지 않는 이유?
        viewModel.output.recentKeywords.bind { [weak self] value in
            print("output recent keywords", value)
            self?.mainView.recentKeywordsView.configureData(keywords: value)
            self?.configureActions()
        }
    }

    @objc
    private func reloadCollectionView() {
        mainView.todaysMovieSection.collectionView.reloadData()
        mainView.profileSection.updateUserInfo()
    }
    
    @objc
    func searchButtonTapped(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
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
        viewModel.input.clearAllKeywords.value = ()
    }
    
    // TODO: 선택 시 순서 변경 되도록 구현
    @objc
    func keywordButtonTapped(_ sender: CustomKeywordButton) {
        let vc = SearchViewController()
        vc.viewModel.input.keywordTapped.value = sender.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func removeKeyword(_ button: CustomKeywordButton) {
        viewModel.input.keywordRemoveTapped.value = button.name
    }
    
    @objc
    private func updateRecentKeywords() {
        print(#function)
        viewModel.input.updateRecentKeywords.value = ()
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
//        vc.movie = viewModel.output.todaysMovies[indexPath.row]
        // TODO: 뷰 전환 시에 넘겨주는 방법에 대한 고민...
        let movie = viewModel.output.todaysMovies[indexPath.row]
        vc.viewModel.input.movie.value = movie
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: Pass Delegate
extension MainViewController: ProfileSettingPassDelegate  {

    func didUpdateProfile() {
        mainView.profileSection.updateUserInfo()
    }
    
}


extension MainViewController {
    
    private func setupView() {
        configureNavigationBar()
        configureView()
        configureNotifications()
    }
    
    private func configureNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateRecentKeywords),
            // TODO: Enum으로 관리
            name: NSNotification.Name("ReceiveKeywordSearch"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView),
            name: NSNotification.Name("ReloadLikedButtons"),
            object: nil
        )
    }
    
    private func configureView() {
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
    
    private func configureActions() {
        mainView.recentKeywordsView.keywordButtons.forEach { button in
            button.onKeywordTapped = { [weak self] in
                self?.keywordButtonTapped(button)
            }
            button.onXmarkTapped = { [weak self] in
                self?.removeKeyword(button)
            }
        }
    }
    
}
