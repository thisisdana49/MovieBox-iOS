//
//  ProfileImageSettingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    var viewModel: ProfileSettingViewModel!
    let profileImages: [UIImage] = [.profile0, .profile1, .profile2, .profile3, .profile4, .profile5, .profile6, .profile7, .profile8, .profile9, .profile10, .profile11 ]
    let mainView = ProfileImageSettingView()
    
    private var selectedIndexPath: IndexPath?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        bindData()
        
        let initialIndex = IndexPath(item: viewModel.outputProfileImageIndex.value, section: 0)
        mainView.collectionView.selectItem(at: initialIndex, animated: false, scrollPosition: .top)
        mainView.imageView.image = profileImages[initialIndex.item]
    }
    
    private func bindData() {
        viewModel.outputProfileImageIndex.bind { [weak self] index in
            self?.mainView.imageView.image = self?.profileImages[index]
        }
    }
    
    fileprivate func configureViewController() {
        navigationItem.title = "프로필 이미지 설정"
                
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.profileImageView.image = profileImages[indexPath.item]
        cell.setSelected(indexPath.item == viewModel.outputProfileImageIndex.value)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputProfileImageSelected.value = indexPath
        
        collectionView.visibleCells.forEach { cell in
            guard let cell = cell as? ProfileImageCollectionViewCell,
                  let cellIndexPath = collectionView.indexPath(for: cell) else { return }
            cell.setSelected(cellIndexPath == indexPath)
        }
    }
    
}
