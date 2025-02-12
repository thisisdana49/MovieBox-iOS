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
    // TODO: mode 속성도 viewmodel로 옮기기
    var mode: ProfileSettingMode = .onboarding
    
    // TODO: VC가 가진 mainView 모두 private
    var viewModel = ProfileSettingViewModel()
    private var mainView: ProfileSettingView!
    
    override func loadView() {
        mainView = ProfileSettingView(mode: mode)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        setupUI()
        configureViewController()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.output.profileImageIndex.bind { [weak self] value in
            print("outputProfileImageIndex", value)
            self?.mainView.imageView.image = UIImage(named: "profile_\(value)")
        }
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.profileImageIndex.bind { [weak self] value in
            print("outputProfileImageIndex", value)
            self?.mainView.imageView.image = UIImage(named: "profile_\(value)")
        }
        
        viewModel.output.guideLabel.bind { [weak self] value in
            self?.mainView.guideLabel.isHidden = false
            self?.mainView.guideLabel.text = value
        }
        
        viewModel.output.nicknameValid.lazyBind { [weak self] value in
            self?.mainView.guideLabel.textColor = value ? .pointBlue : .pointRed
        }
        
        viewModel.output.registerAvailable.bind { [weak self] value in
            self?.mainView.completeButton.isEnabled = value
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

    @objc
    func dismissView() {
        dismiss(animated: true)
    }
    
    @objc
    func imageViewTapped() {
        let vc = ProfileImageSettingViewController()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func completeButtonTapped() {
        viewModel.input.completeButtonTapped.value = ()
        
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
        viewModel.input.nicknameText.value = textField.text
        viewModel.input.registerAvailable.value = ()
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
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            for selectedIndexPath in selectedItems where selectedIndexPath != indexPath {
                collectionView.deselectItem(at: selectedIndexPath, animated: true)
                if let cell = collectionView.cellForItem(at: selectedIndexPath) as? MBTICollectionViewCell {
                    cell.updateUI()
                }
            }
        }
        
        mainView.mbtiSection.collectionViews.forEach { view in
            // TODO: view.indexPathsForSelectedItems 활용한 로직으로 변경해보기!
            print(view.indexPathsForSelectedItems)
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MBTICollectionViewCell {
            cell.updateUI()
        }
        
        viewModel.input.mbtiCellTapped.value = (collectionView.tag, indexPath)
        viewModel.input.registerAvailable.value = ()
    }
    
}


extension ProfileSettingViewController {
    
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
            view.allowsMultipleSelection = true
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
    
}

// MARK: Pass Delegate
extension ProfileSettingViewController: ProfileImagePassDelegate {
    
    func didSelectProfileImage(_ imageIndex: Int) {
        mainView.imageView.image = UIImage(named: "profile_\(imageIndex)")
    }
    
}
