//
//  AlertNextView.swift
//  ABCApp
//
//  Created by apple on 2024/4/2.
//

import UIKit

class AlertNextView: UIView {
    
    lazy var nameLabel: UILabel = {
        let label1 = UILabel()
        label1.text = "Name"
        label1.textAlignment = .left
        label1.textColor = UIColor.init("#263738")
        label1.font = UIFont(name: kOSRegular, size: 24.px())
        return label1
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: CGRectMake(0, 0, 50.px(), 50.px()))
        iconImageView.image = UIImage(named: "icon_inputfad")
        return iconImageView
    }()
    
    lazy var textF: UITextField = {
        let textF = UITextField()
        let totlaStr = "Name"
        textF.leftView = UIView.init(frame: CGRectMake(0, 0, 10, 10))
        textF.leftViewMode = .always
        textF.layer.cornerRadius = 15.px()
        textF.rightView = iconImageView
        textF.rightViewMode = .always
        textF.font = UIFont(name: kOSBold, size: 24.px())
        textF.backgroundColor = UIColor.init("#FFFAE7")
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: kOSRegular, size: 24.0)!,
            .foregroundColor: UIColor.init("#DDAE02")
        ]
        let attributedPlaceholder = NSAttributedString(string: totlaStr, attributes: attributes)
        textF.attributedPlaceholder = attributedPlaceholder
        return textF
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(textF)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(17.px())
            make.top.equalTo(self)
            make.height.equalTo(33.px())
        }
        textF.snp.makeConstraints { make in
            make.left.equalTo(self).offset(17.px())
            make.top.equalTo(nameLabel.snp.bottom).offset(10.px())
            make.centerX.equalTo(self)
            make.height.equalTo(50.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
