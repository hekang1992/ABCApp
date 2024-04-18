//
//  WorkInformationWalletCell.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

class WorkInformationWalletCell: UITableViewCell {
    
    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(17.px(), 0.px(), 340.px(), 33.px()))
        titLabel.textColor = UIColor.init("#263738")
        titLabel.font = UIFont(name: kOSBold, size: 24.px())
//        titLabel.text = "Camera";
        return titLabel
    }()
    
    lazy var conTF: UITextField = {
        let conTF = UITextField(frame: CGRectMake(17.px(), CGRectGetMaxY(self.titLabel.frame) + 8.px(), 341.px(), 70.px()))
        conTF.textColor = UIColor.init("#333333")           
        conTF.font = UIFont(name: kOSBold, size: 24.px())
        conTF.isUserInteractionEnabled = false
        conTF.backgroundColor = UIColor.white
        conTF.layer.masksToBounds = true
        conTF.layer.cornerRadius = 15.px()
        
        conTF.leftViewMode = .always
        
        let leftView = UIView(frame: CGRectMake(0, 0, 75.px(), 70.px()))
        leftView.addSubview(leftConImgView)
        leftView.backgroundColor = UIColor.white
        conTF.leftView = leftView
        
        conTF.rightViewMode = .always
        let rightView = UIView(frame: CGRectMake(0, 0, 60.px(), 70.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 13.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "confirm_popSlice 2")
        rightView.addSubview(backImgView)
        
        conTF.rightView = rightView
        
        let totlaStr = "Camera";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        conTF.attributedPlaceholder = attributedString
        return conTF
    }()
    
    lazy var leftConImgView: UIImageView = {
        let leftConImgView = UIImageView(frame: CGRectMake(12.px(), 12.px(), 46.px(), 46.px()))
        leftConImgView.backgroundColor = UIColor.init("#FFC801")
        leftConImgView.layer.masksToBounds = true
        leftConImgView.layer.cornerRadius = 23.px()
        
        return leftConImgView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(self.titLabel)
        self.contentView.addSubview(self.conTF)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
