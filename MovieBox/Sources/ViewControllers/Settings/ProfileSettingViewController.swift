//
//  ProfileSettingViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

enum ProfileSettingMode {
    case onboarding
    case edit(currentNickname: String)
}

final class ProfileSettingViewController: UIViewController {
    
    var passDelegate: ProfileSettingPassDelegate?
    var mode: ProfileSettingMode = .onboarding
    
    var nickname: String = ""
    // TODO: VC가 가진 mainView 모두 private
    var viewModel = ProfileSettingViewModel()
    private var mainView: ProfileSettingView!
    
    override func loadView() {
        mainView = ProfileSettingView(mode: mode)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureViewController()
        bindData()
    }
    
    private func bindData() {
        viewModel.inputViewDidLoad.value = ()
        
        viewModel.outputProfileImageIndex.bind { [weak self] value in
            print("outputProfileImageIndex", value)
            self?.mainView.profileImage = value
        }
        
        viewModel.outputGuideLabel.bind { [weak self] value in
            self?.mainView.guideLabel.isHidden = false
            self?.mainView.guideLabel.text = value
        }
        
        viewModel.outputNicknameValid.lazyBind { [weak self] value in
            self?.mainView.guideLabel.textColor = value ? .pointBlue : .pointRed
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureActions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passDelegate?.didUpdateProfile()
    }
    
    private func setupUI() {
        switch mode {
        case .onboarding:
            navigationItem.title = "프로필 설정"
        case .edit(let currentNickname):
            navigationItem.title = "프로필 수정"
            mainView.textField.text = currentNickname
            setupNavigationBarButton()
        }
    }
    
    private func setupNavigationBarButton() {
        let completeButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(completeButtonTapped))
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = completeButton
        navigationItem.setLeftBarButton(dismissButton, animated: true)
    }
    
    private func configureViewController() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        mainView.imageView.addGestureRecognizer(tapGesture)
        
        mainView.textField.delegate = self
        
        mainView.mbtiSection.collectionViews.forEach { view in
            view.delegate = self
            view.dataSource = self
            view.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.id)
        }
        
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.baseBlack]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .baseWhite
        navigationController?.navigationBar.tintColor = .baseBlack
    }
    
    private func configureActions() {
        mainView.textField.becomeFirstResponder()
        mainView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    // TODO: 리팩토링
    @objc
    func dismissView() {
        dismiss(animated: true)
    }
    
    @objc
    func imageViewTapped() {
        let vc = ProfileImageSettingViewController()
        vc.passDelegate = self
        vc.profileImage = mainView.profileImage
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func completeButtonTapped() {
        viewModel.inputCompleteButtonTapped.value = ()
        
        switch mode {
        case .onboarding:
            // TODO: extension + enum
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
            
            window.rootViewController = TabBarViewController()
            window.makeKeyAndVisible()
        case .edit:
            dismiss(animated: true)
        }
    }
}

// MARK: TextField Delegated
extension ProfileSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.inputNicknameText.value = textField.text
        
//        nickname = inputText
//        validateNickname(nickname)
    }
    
}

extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.id, for: indexPath) as! MBTICollectionViewCell
        
        if collectionView.tag == 0 {
            if indexPath.item == 0 {
                cell.configureData(with: "E")
            } else {
                cell.configureData(with: "I")
            }
        }
        if collectionView.tag == 1 {
            if indexPath.item == 0 {
                cell.configureData(with: "S")
            } else {
                cell.configureData(with: "N")
            }
        }
        if collectionView.tag == 2 {
            if indexPath.item == 0 {
                cell.configureData(with: "T")
            } else {
                cell.configureData(with: "F")
            }
        }
        if collectionView.tag == 3 {
            if indexPath.item == 0 {
                cell.configureData(with: "J")
            } else {
                cell.configureData(with: "P")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.id, for: indexPath) as! MBTICollectionViewCell
        print(#function)
        mainView.mbtiSection.collectionViews.forEach { view in
            print(view.indexPathsForSelectedItems)
        }
    }
    
}

// MARK: Pass Delegate
extension ProfileSettingViewController: ProfileImagePassDelegate {
    
    func didSelectProfileImage(_ imageIndex: Int) {
        mainView.profileImage = imageIndex
        mainView.imageView.image = UIImage(named: "profile_\(imageIndex)")
    }
    
}
