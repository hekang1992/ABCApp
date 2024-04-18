//
//  OrderCell1.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit
import SnapKit

typealias OrderCell1BlockClass = () -> ()


class OrderCell1: UITableViewCell {
    
    var selBlock:OrderCell1BlockClass?

    
    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(90.px(), 15.px(), 236.px(), 25.px()))
        titLabel.textColor = UIColor.init("#212F30")
        titLabel.font = UIFont(name: kOSBold, size: 18.px())
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
    
    lazy var lineView: UIView = {
        
        let view = UIView(frame: CGRectMake(90.px(), 45.px(), 236.px(), 0.5.px()))
        view.backgroundColor = UIColor.init("#212F30")
        return view;
        
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
        

        conBottomView.addSubview(lineView1)
        
        conBottomView.addSubview(selBtn)
        
        return conBottomView
    }()
    
    lazy var lineView1: UIView = {
        let lineView = UIView.init(frame: CGRectMake(233.px(), 16.px(), 1.px(), 15.px()));
        lineView.backgroundColor = UIColor.white
        return lineView
    }()
    
    lazy var conBottomDescLabel: UILabel = {
        let conBottomDescLabel = UILabel(frame: CGRectMake(15.px(), 12.px(), 218.px(), 22.px()))
        conBottomDescLabel.textColor = UIColor.white
        conBottomDescLabel.font = UIFont(name: kOSRegular, size: 16.px())
        conBottomDescLabel.numberOfLines = 0;
        return conBottomDescLabel
    }()
    
    lazy var selBtn: UIButton = {
        let selBtn = UIButton(type: .custom)
        selBtn.setTitleColor(UIColor.white, for: .normal)
        selBtn.titleLabel?.font = UIFont(name: kOSRegular, size: 16.px())
//        selBtn.setTitle("Repay", for: .normal)
        selBtn.addTarget(self, action: #selector(selBtnAction), for: .touchUpInside)
        return selBtn
    }()
    
    lazy var bgView : UIView = {
        let bgView = UIView.init(frame: CGRectMake(17.px(), 20.px(), 341.px(), 150.px()));
        bgView.backgroundColor = UIColor.white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 15.px()
        return bgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
       
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(20.px())
            make.left.leading.equalTo(17.px())
            make.width.equalTo(341.px())
            make.bottom.leading.equalTo(0.px())
        }
        
        bgView.addSubview(lineView)
        
        bgView.addSubview(self.titLabel)
        bgView.addSubview(self.subTitLabel)
        bgView.addSubview(self.conImgView)
        bgView.addSubview(self.priceLabel)
        bgView.addSubview(conBottomView)
        
        
    }
    
    public func setCellConViewAction(conModel:OrderModel){
        
        self.selBtn.isHidden = true;
        self.lineView.isHidden = true;
        var btnWidth = 0.px()
        var textWidth =  kScreenWidth - 64.px() - 30.px()
        if (conModel.myTree?.count ?? 0 > 0){
            // 获取按钮宽度
            btnWidth = AppHelper.getStrWidth(str: conModel.myTree ?? "", height: 20.px(), font:  UIFont(name: kOSRegular, size: 16.px())!)
            btnWidth += 30.px()
            
            textWidth = kScreenWidth - 64.px() - 15.px() - btnWidth - 9.px()
            selBtn.setTitle(conModel.myTree, for: .normal)
            self.selBtn.isHidden = false;
            self.lineView.isHidden = false;
            
        }
        var textHeight = 46.px()
        var realTextH = AppHelper.getStrHeight(str: conModel.flowed ?? "", width: textWidth, font: UIFont(name: kOSRegular, size: 16.px())!) + 20.px()
        textHeight = textHeight > realTextH ? textHeight : realTextH
        
        selBtn.frame = CGRectMake(311.px() - btnWidth, 0, btnWidth, textHeight)
        
        var lineView1Top = 15.px()
        if (textHeight > 50.px()){
            lineView1Top = 19.px()
        }
        
        lineView1.frame = CGRectMake(CGRectGetMinX(selBtn.frame), lineView1Top, 1.px(), textHeight - lineView1Top * 2)
        conBottomDescLabel.frame = CGRectMake(15.px(), 0.px(), textWidth, textHeight)
        conBottomDescLabel.text = conModel.flowed
        
        self.conBottomView.frame = CGRectMake(15.px(), 89.px(), 311.px(), textHeight)        
        
    }
    
    @objc func selBtnAction(){
        
        self.selBlock!()
    }
 
 func selblockAction(block: @escaping OrderCell1BlockClass) -> Void {
     self.selBlock = block
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
