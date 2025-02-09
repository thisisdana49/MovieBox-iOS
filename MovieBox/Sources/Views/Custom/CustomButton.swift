//
//  CustomButton.swift
//  MovieBox
//
//  Created by 조다은 on 1/25/25.
//

import UIKit

final class CustomButton: UIButton {
    
    enum Styles: String {
        case bordered
        case filled
    }
    
    override var isEnabled: Bool {
        didSet {
            updateUI()
        }
    }
    
    var title: String = ""

    init(title: String, style: CustomButton.Styles) {
        super.init(frame: .zero)
        
        if style == .bordered { configureBorderedButton(title: title) }
        else if style == .filled { configureFilledButton(title: title) }
    }
    
    func updateButtonTitle(_ title: String) {
        configureFilledButton(title: title)
    }
    
    private func updateUI() {
        // TODO: 왜 Disabled 시 color가 변경되지 않는지?
        if !isEnabled {
            print("it is disabled")
            configuration?.baseBackgroundColor = .baseGray
        } else {
            configuration?.baseBackgroundColor = .pointBlue
        }
    }
    
    private func configureBorderedButton(title: String) {
        var config = UIButton.Configuration.filled()
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.baseBackgroundColor = .pointBlue
            case .disabled:
                button.configuration?.baseBackgroundColor = .baseGray
            default:
                button.configuration?.baseBackgroundColor = .pointBlue
            }
        }
        
        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        config.attributedTitle = titleAttr
        
        config.baseForegroundColor = .baseWhite
        config.baseBackgroundColor = isEnabled ? .pointBlue : .baseGray
        
        config.cornerStyle = .capsule
//        config.background.strokeWidth = 2
//        config.background.strokeColor = .mainBlue
        
        configurationUpdateHandler = handler
        configuration = config
    }
    
    private func configureFilledButton(title: String) {
        var config = UIButton.Configuration.filled()

        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        config.attributedTitle = titleAttr
        
        config.baseBackgroundColor = .mainBlue
        config.baseForegroundColor = .baseWhite
        
        config.cornerStyle = .fixed
        config.background.cornerRadius = 8
        
        configuration = config
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBorderedButton(title: "")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
