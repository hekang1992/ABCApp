//
//  Root2ViewCell.swift
//  ABCApp
//
//  Created by Boris on 2024/2/28.
//

import UIKit

class Root2ViewCell: UITableViewCell {

    lazy var backView: UIView = {
        let backView = UIImageView(frame: CGRectMake(17.px(), 10.px(), 341.px(), 132.px()))
        backView.backgroundColor = UIColor.white
        backView.layer.masksToBounds = true;
        backView.layer.cornerRadius = 20.px()
        return backView
    }()
    
    
    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(15.px(), 15.px(), 250.px(), 25.px()))
        titLabel.textColor = UIColor.init("#212F30")
        titLabel.font = UIFont(name: kOSBold, size: 18.px())
        titLabel.text = "ACE CashACE CashACE "
        return titLabel
    }()
    
    lazy var subTitLabel: UILabel = {
        let subTitLabel = UILabel(frame: CGRectMake(15.px(), 51.px(), 250.px(), 22.px()))
        subTitLabel.textColor = UIColor.init("#299F2D")
        subTitLabel.font = UIFont(name: kOSRegular, size: 16.px())
        subTitLabel.text = "Borrowed 10 times!";
        return subTitLabel
    }()
    
      
    lazy var lineView: UIView = {
        
        let view = UIView(frame: CGRectMake(15.px(), 44.px(), 236.px(), 0.5.px()))
        view.backgroundColor = UIColor.init("#212F30")
        return view;
        
    }()
    
    lazy var peoImgView: UIImageView = {
        let peoImgView = UIImageView(frame: CGRectMake(220.px(), 52.px(), 76.px(), 52.px()))
        peoImgView.image = UIImage(named: "homecell2")
        return peoImgView
    }()
    
    lazy var conImgView: UIImageView = {
        let conImgView = UIImageView(frame: CGRectMake(274.px(), 15.px(), 52.px(), 52.px()))
        conImgView.backgroundColor = UIColor.init("#FFC801")
        conImgView.layer.masksToBounds = true
        conImgView.layer.cornerRadius = 10.px()
        return conImgView
    }()

    lazy var selBtn: UIButton = {
        let selBtn = UIButton(type: .custom)
        selBtn.setTitleColor(UIColor.white, for: .normal)
        selBtn.titleLabel?.font = UIFont(name: kOSBold, size: 18.px())
        selBtn.frame = CGRectMake(15.px(), 82.px(), 311.px(), 35.px())
        selBtn.layer.masksToBounds = true;
        selBtn.layer.cornerRadius = 10.px()
        return selBtn
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.backView)
        backView.addSubview(self.titLabel)
        backView.addSubview(self.lineView)
        backView.addSubview(self.subTitLabel)
        backView.addSubview(self.conImgView)
        backView.addSubview(self.selBtn)
        backView.addSubview(self.peoImgView)
        
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
