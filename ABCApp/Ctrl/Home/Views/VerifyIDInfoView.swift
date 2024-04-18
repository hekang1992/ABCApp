//
//  VerifyIDInfoView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

typealias VerifyIDInfoViewSaveBlockClass = (_ name:String, _ number:String, _ date:String) -> ()


class VerifyIDInfoView: UIView {
    
    var confirmBlock: VerifyIDInfoViewSaveBlockClass?

    
    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 110.px() - 432.px(), kScreenWidth, 110.px()))
        backImgView.image = UIImage(named: "bg_idconfirm")
        backImgView.isUserInteractionEnabled = true
        
        return backImgView
    }()
    
    lazy var conView : UIView = {
        let backImgView = UIView(frame: CGRectMake(0, kScreenHeight - 432.px(), kScreenWidth, 432.px()))
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backImgView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backImgView.layer.addSublayer(bgLayer1)
        
        backImgView.addSubview(tit1Label)
        backImgView.addSubview(tit2Label)
        backImgView.addSubview(tit3Label)
        
        backImgView.addSubview(con1TF)
        backImgView.addSubview(con2TF)
        backImgView.addSubview(con3TF)
        
        backImgView.addSubview(self.confirmBtn)
        
        
        return backImgView
    }()
    
    lazy var tit1Label: UILabel = {
        let tit1Label = UILabel(frame: CGRectMake(17.px(), 0.px(), 300.px(), 33.px()))
        tit1Label.textColor = UIColor.init("#263738")
        tit1Label.font = UIFont(name: kOSBold, size: 24.px())
        tit1Label.text = "Name";
        return tit1Label
    }()
    
    lazy var con1TF: UITextField = {
        let con1TF = UITextField(frame: CGRectMake(17.px(), CGRectGetMaxY(self.tit1Label.frame) + 8.px(), 341.px(), 50.px()))
        con1TF.textColor = UIColor.init("#333333")
        con1TF.font = UIFont(name: kOSBold, size: 22.px())
//        con1TF.text = "Camera";
        con1TF.backgroundColor = UIColor.white
        con1TF.layer.masksToBounds = true
        con1TF.layer.cornerRadius = 15.px()
        
        con1TF.leftViewMode = .always
        con1TF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        
        con1TF.rightViewMode = .always
        let rightView = UIView(frame: CGRectMake(0, 0, 60.px(), 50.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 3.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "confirm_popicon_input")
        rightView.addSubview(backImgView)
        
        con1TF.rightView = rightView
        
        let totlaStr = " ";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        con1TF.attributedPlaceholder = attributedString
        return con1TF
    }()
    
    lazy var tit2Label: UILabel = {
        let tit2Label = UILabel(frame: CGRectMake(17.px(), CGRectGetMaxY(self.tit1Label.frame) + 78.px(), 300.px(), 33.px()))
        tit2Label.textColor = UIColor.init("#263738")
        tit2Label.font = UIFont(name: kOSBold, size: 24.px())
        tit2Label.text = "Number";
        return tit2Label
    }()
    
    lazy var con2TF: UITextField = {
        let con2TF = UITextField(frame: CGRectMake(17.px(), CGRectGetMaxY(self.tit2Label.frame) + 8.px(), 341.px(), 50.px()))
        con2TF.textColor = UIColor.init("#333333")
        con2TF.font = UIFont(name: kOSBold, size: 22.px())
//        con1TF.text = "Camera";
        con2TF.backgroundColor = UIColor.white
        con2TF.layer.masksToBounds = true
        con2TF.layer.cornerRadius = 15.px()
//        con2TF.keyboardType = .numberPad
        con2TF.leftViewMode = .always
        con2TF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        
        con2TF.rightViewMode = .always
        let rightView = UIView(frame: CGRectMake(0, 0, 60.px(), 50.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 3.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "confirm_popicon_input")
        rightView.addSubview(backImgView)
        
        con2TF.rightView = rightView
        
        let totlaStr = " ";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        con2TF.attributedPlaceholder = attributedString
        return con2TF
    }()
    
    lazy var tit3Label: UILabel = {
        let tit3Label = UILabel(frame: CGRectMake(17.px(), CGRectGetMaxY(self.tit2Label.frame) + 78.px(), 300.px(), 33.px()))
        tit3Label.textColor = UIColor.init("#263738")
        tit3Label.font = UIFont(name: kOSBold, size: 22.px())
        tit3Label.text = "Birthday";
        return tit3Label
    }()
    
    lazy var con3TF: UIView = {
        let con3TF = UIView(frame: CGRectMake(17.px(), CGRectGetMaxY(self.tit3Label.frame) + 8.px(), 341.px(), 50.px()))

//        con1TF.text = "Camera";
        con3TF.backgroundColor = UIColor.white
        con3TF.layer.masksToBounds = true
        con3TF.layer.cornerRadius = 15.px()
        
        con3TF.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseDateAction)))
        

        con3TF.addSubview(con3Label)
        
        let leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        con3TF.addSubview(leftView)
        
        
        let rightView = UIView(frame: CGRectMake(281.px(), 0, 60.px(), 50.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 3.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "confirm_popSlice 2")
        rightView.addSubview(backImgView)
        
        con3TF.addSubview(rightView)
        
//        let totlaStr = " ";
//        let attributedString = NSMutableAttributedString.init(string: totlaStr)
//        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
//        con3TF.attributedPlaceholder = attributedString
        return con3TF
    }()
    
    lazy var con3Label: UILabel = {
        
let conLabel = UILabel(frame: CGRectMake(17.px(), 0, 260.px(), 50.px()))
conLabel.textColor = UIColor.init("#333333")
conLabel.font = UIFont(name: kOSBold, size: 24.px())
        return conLabel
    }()
 
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), CGRectGetMinY(self.backImgView.frame) - 35.px(), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeBtn
        
    }()
    
   

    
    lazy var confirmBtn:UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(tit3Label.frame) + 88.px(), 341.px(), 50.px())
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 15.px()
        
        confirmBtn.backgroundColor = UIColor.init("#299F2D")
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        return confirmBtn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha:0.6)
        self.addSubview(self.backImgView)
        self.addSubview(self.conView)
        self.addSubview(self.closeBtn)
        
        
        
    }
    

    @objc func confirmAction (){
        
        self.confirmBlock!(self.con1TF.text!, self.con2TF.text!, self.con3Label.text!)
        
    }                                                                                                      
    
    func confirmBlockAction(block: @escaping VerifyIDInfoViewSaveBlockClass) -> Void {
        self.confirmBlock = block
    }
    
    
    @objc func closeAction (){
        self.removeFromSuperview()
    }
    
    @objc func chooseDateAction  (){
        
        let chooseView = ChooseDateView(frame: self.bounds)
        
        chooseView.setDateStr(self.con3Label.text!)
        
        chooseView.dateSelBlockAction { dateStr in
            
            // 展示 变成 日月年
            
            self.con3Label.text = dateStr
            
        }
        self.addSubview(chooseView)
        
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
