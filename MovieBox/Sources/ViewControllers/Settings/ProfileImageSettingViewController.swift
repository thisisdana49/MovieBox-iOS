//
//  ProfileImageSettingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    
    var passDelegate: ProfileImagePassDelegate?
    
    var profileImage: Int = 0
    let profileImages: [UIImage] = [.profile0, .profile1, .profile2, .profile3, .profile4, .profile5, .profile6, .profile7, .profile8, .profile9, .profile10, .profile11 ]
    let mainView = ProfileImageSettingView()
    
    private var selectedIndexPath: IndexPath?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        selectedIndexPath = IndexPath(item: profileImage, section: 0)
        mainView.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        mainView.imageView.image = profileImages[selectedIndexPath?.row ?? 0]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        passDelegate?.didSelectProfileImage(selectedIndexPath?.row ?? 0)
    }
    
    fileprivate func configureViewController() {
        navigationItem.title = "프로필 이미지 설정"
        
        mainView.imageView.image = UIImage(named: "profile_\(profileImage)")
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        cell.profileImageView.image = profileImages[indexPath.item]
        
        if indexPath == selectedIndexPath {
            cell.setSelected(true)
        } else {
            cell.setSelected(false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? ProfileImageCollectionViewCell
            previousCell?.setSelected(false)
        }
        
        let currentCell = collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell
        currentCell?.setSelected(true)
        
        selectedIndexPath = indexPath
        mainView.imageView.image = profileImages[indexPath.row]
    }
    
}
