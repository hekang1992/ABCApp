//
//  MessageCell.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

class MessageCell: UITableViewCell {
    
    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(90.px(), 15.px(), 236.px(), 25.px()))
        titLabel.textColor = UIColor.init("#212F30")
        titLabel.font = UIFont(name: kOSBold, size: 18.px())
        titLabel.text = "Orders";
        return titLabel
    }()
    
    lazy var subTitLabel: UILabel = {
        let subTitLabel = UILabel(frame: CGRectMake(90.px(), 54.px(), 200.px(), 22.px()))
        subTitLabel.textColor = UIColor.init("#000000")
        subTitLabel.font = UIFont(name: kOSRegular, size: 16.px())
        subTitLabel.text = "Loan amount";
        return subTitLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel(frame: CGRectMake(200.px(), 54.px(), 112.px(), 22.px()))
        priceLabel.textColor = UIColor.init("#299F2D")
        priceLabel.font = UIFont(name: kOSRegular, size: 16.px())
        priceLabel.text = "10000";
        priceLabel.textAlignment = .right
        return priceLabel
    }()
    
    
    lazy var peoImgView: UIImageView = {
        let peoImgView = UIImageView(frame: CGRectMake(240.px(), CGRectGetMidY(priceLabel.frame) - 6.5.px(), 13.px(), 13.px()))
        peoImgView.image = UIImage(named: "icon_peso")
        return peoImgView
    }()
    
    lazy var conImgView: UIImageView = {
        let conImgView = UIImageView(frame: CGRectMake(15.px(), 15.px(), 60.px(), 60.px()))
        conImgView.backgroundColor = UIColor.init("#FFC801")
        conImgView.layer.masksToBounds = true
        conImgView.layer.cornerRadius = 10.px()
        return conImgView
    }()
    
    lazy var conBottomView: UIView = {
        let conBottomView = UIView(frame: CGRectMake(15.px(), 89.px(), 311.px(), 46.px()))
        conBottomView.backgroundColor = UIColor.init("#299F2D")
        conBottomView.layer.masksToBounds = true
        conBottomView.layer.cornerRadius = 15.px()
        conBottomView.addSubview(conBottomDescLabel)
        
        let lineView = UIView.init(frame: CGRectMake(233.px(), 16.px(), 1.px(), 15.px()));
        lineView.backgroundColor = UIColor.white
        conBottomView.addSubview(lineView)
        
        conBottomView.addSubview(selBtn)
        
        return conBottomView
    }()
    
    lazy var conBottomDescLabel: UILabel = {
        let conBottomDescLabel = UILabel(frame: CGRectMake(15.px(), 12.px(), 218.px(), 22.px()))
        conBottomDescLabel.textColor = UIColor.white
        conBottomDescLabel.font = UIFont(name: kOSRegular, size: 16.px())
        conBottomDescLabel.text = "2 Days until the repayment date";
        return conBottomDescLabel
    }()
    
    lazy var selBtn: UIButton = {
        let selBtn = UIButton(type: .custom)
        selBtn.frame = CGRectMake(234.px(), 0, 78.px(), 46.px())
        selBtn.setTitleColor(UIColor.white, for: .normal)
        selBtn.titleLabel?.font = UIFont(name: kOSRegular, size: 16.px())
        selBtn.setTitle("Repay", for: .normal)
        return selBtn
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        let bgView = UIView.init(frame: CGRectMake(17.px(), 20.px(), 341.px(), 150.px()));
        bgView.backgroundColor = UIColor.white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 15.px()
        self.contentView.addSubview(bgView)
        
        bgView.addSubview(self.titLabel)
        bgView.addSubview(self.subTitLabel)
        bgView.addSubview(self.conImgView)
        bgView.addSubview(self.priceLabel)
        bgView.addSubview(peoImgView)
        bgView.addSubview(conBottomView)
        
        
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
