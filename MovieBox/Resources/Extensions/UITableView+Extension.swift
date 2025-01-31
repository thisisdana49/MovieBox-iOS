//
//  UITableView+Extension.swift
//  MovieBox
//
//  Created by 조다은 on 1/30/25.
//

import UIKit
import SnapKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .gray2
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            label.sizeToFit()
            return label
        }()
//        addSubview(messageLabel)
//        
//        messageLabel.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(200)
//            make.centerX.equalToSuperview()
//        }
        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }

}
