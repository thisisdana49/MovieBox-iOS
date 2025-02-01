//
//  UICollectionView+Extension.swift
//  MovieBox
//
//  Created by 조다은 on 1/30/25.
//

import UIKit
import SnapKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .gray1
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
