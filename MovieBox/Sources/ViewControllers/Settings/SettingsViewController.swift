//
//  SettingsViewController.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

class SettingsViewController: UIViewController {

    let mainView = SettingsView()
    let list: [String] = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        navigationItem.title = "설정"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.profileSection.updateUserInfo()
    }

}

// MARK: TableView Delegate, TableView DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.textColor = .baseWhite
        cell.backgroundColor = .baseBlack
        
        if indexPath.row == 3 {
            
        } else {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            AlertManager.shared.showAlert(
                on: self,
                title: "탈퇴하기",
                message: "탈퇴를 하면 데이터가 모두 초기화 됩니다. 탈퇴하시겠습니까?",
                actions: [
                    UIAlertAction(title: "확인", style: .destructive, handler: { _ in
                        UserDefaultsManager.clearAll()
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
                        
                        window.rootViewController = OnboardingViewController()
                        window.makeKeyAndVisible()
                    }),
                    UIAlertAction(title: "취소", style: .cancel)
                ]
            )
        }
    }
}
