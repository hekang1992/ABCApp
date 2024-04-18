//
//  ChooseIDTypeView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

typealias ChooseIDTypeViewwBlockClass = (_ typeStr:String) -> ()

class ChooseIDTypeView: UIView {
    
    var selTypeBlock: ChooseIDTypeViewwBlockClass?


    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 110.px() - 423.px(), kScreenWidth, 110.px()))
        backImgView.image = UIImage(named: "bg_idconfirm")
        backImgView.isUserInteractionEnabled = true
        
        return backImgView
    }()
    
    lazy var conView : UIView = {
        let backImgView = UIView(frame: CGRectMake(0, kScreenHeight - 423.px(), kScreenWidth, 423.px()))
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backImgView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backImgView.layer.addSublayer(bgLayer1)
        
        backImgView.addSubview(confirmConView)
        
        backImgView.addSubview(self.chooseBtn)
        backImgView.addSubview(self.confirmBtn)
        
        return backImgView
    }()
    
    lazy var confirmConView : UIView = {
        let backImgView = UIView(frame: CGRectMake(17.px(), 0, 341.px(), 222.px()))
        backImgView.backgroundColor = UIColor.init("#FFFAE7")
        backImgView.layer.masksToBounds = true
        backImgView.layer.cornerRadius = 25.px()
        
        backImgView.addSubview(chooseImgView)
        
        
        let conTLabel = UILabel(frame: CGRectMake(152.px(), 15.px(), 174.px(), 50.px()))
        conTLabel.text = "The document type you have selected is"
        conTLabel.font =  UIFont(name: kOSRegular, size: 18.px())
        conTLabel.numberOfLines = 0
        conTLabel.textColor = UIColor.init("#299F2D")
        backImgView.addSubview(conTLabel)
        
        backImgView.addSubview(selLabel)
        
        let descLabel = UILabel(frame: CGRectMake(15.px(), 93.px(), 311.px(), 130.px()))
        descLabel.text = "Ensure that the document type you selected for upload matches the type of your actual document, as any discrepancy may result in the failure of the verification process."
        descLabel.numberOfLines = 0
        descLabel.font =  UIFont(name: kOSRegular, size: 18.px())
        descLabel.textColor = UIColor.init("#212F30")
        backImgView.addSubview(descLabel)
        
        return backImgView
    }()
    
    lazy var selLabel:UILabel = {
        let selLabel = UILabel(frame: CGRectMake(152.px(), 65.px(), 174.px(), 30.px()))
        selLabel.font =  UIFont(name: kOSRegular, size: 21.px())
        selLabel.textColor = UIColor.init("#299F2D")
        return selLabel
    }()
    
    lazy var chooseImgView : UIImageView = {
        let chooseImgView = UIImageView(frame: CGRectMake(15.px(), 15.px(), 125.px(), 77.px()))
        chooseImgView.isUserInteractionEnabled = true
        chooseImgView.backgroundColor = UIColor.init("#FFEFB8")
        return chooseImgView
    }()
    
    
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), CGRectGetMinY(self.backImgView.frame) - 35.px(), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeBtn
        
    }()
    
   
    lazy var chooseBtn: UIButton = {
        
        let chooseBtn = UIButton(type: .custom)
        chooseBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(confirmConView.frame) + 30.px(), 341.px(), 50.px())
        chooseBtn.layer.masksToBounds = true
        chooseBtn.layer.cornerRadius = 15.px()
        
        chooseBtn.backgroundColor = UIColor.white
        chooseBtn.setTitle("Modify ID Type", for: .normal)
        chooseBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        chooseBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        chooseBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)

        return chooseBtn
    }()
    
    lazy var confirmBtn:UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(chooseBtn.frame) + 30.px(), 341.px(), 50.px())
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 15.px()
        
        confirmBtn.backgroundColor = UIColor.init("#299F2D")
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        confirmBtn.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)

        return confirmBtn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha:0.6)
        self.addSubview(self.backImgView)
        self.addSubview(self.conView)
        self.addSubview(self.closeBtn)
                
    }
    
    @objc func closeAction(){
        self.removeFromSuperview()
    }
    
    @objc func confirmBtnAction(){
        
        self.selTypeBlock!(self.selLabel.text!)
    }
    
    func selTypeBlockAction(block: @escaping ChooseIDTypeViewwBlockClass) -> Void {
        self.selTypeBlock = block
    }
    
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
