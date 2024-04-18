//
//  LogOffPopView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

typealias LogOffPopViewBlockClass = () -> ()


class LogOffPopView: UIView {
    
    var selBlock:LogOffPopViewBlockClass?
    
    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 110.px() - 530.px(), kScreenWidth, 110.px()))
        backImgView.image = UIImage(named: "bg_idconfirm")
        backImgView.isUserInteractionEnabled = true
        
        return backImgView
    }()
    
    lazy var conView : UIView = {
        let backImgView = UIView(frame: CGRectMake(0, kScreenHeight - 530.px(), kScreenWidth, 530.px()))
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backImgView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backImgView.layer.addSublayer(bgLayer1)
        
        let conLabelBack = UIView(frame: CGRectMake(17.px(), 20.px(), 341.px(), 230.px()))
        conLabelBack.backgroundColor = UIColor.white
        conLabelBack.layer.masksToBounds = true
        conLabelBack.layer.cornerRadius = 15.px()
        backImgView.addSubview(conLabelBack)
        
        let conLabel1 = UILabel(frame: CGRectMake(15.px(), 0, 311.px(), 230.px()))
        conLabel1.text = "Dear valued customer,\nIf you're dissatisfied, we're eager to improve. Let us customize solutions to meet your needs and enhance your satisfaction. Please give us a chance to deliver a better experience for you.\nThank you for considering another\n opportunity with us."
        conLabel1.textColor = UIColor.init("#263738")
        conLabel1.font = UIFont(name: kOSRegular, size: 18.px())
        conLabel1.numberOfLines = 0;
        conLabelBack.addSubview(conLabel1)
        
        let conBottomBack = UIView(frame: CGRectMake(17.px(), CGRectGetMaxY(conLabelBack.frame) + 20.px(), 341.px(), 105.px()))
        conBottomBack.backgroundColor = UIColor.white
        conBottomBack.layer.masksToBounds = true
        conBottomBack.layer.cornerRadius = 15.px()
        backImgView.addSubview(conBottomBack)
        
        let conLabel2 = UILabel(frame: CGRectMake(15.px(), 0, 311.px(), 105.px()))
        conLabel2.text = "After deactivation, you can't sign in, and all related information, including orders and personal details, will be permanently erased."
        conLabel2.textColor = UIColor.init("#FF5D00")
        conLabel2.font = UIFont(name: kOSRegular, size: 18.px())
        conLabel2.numberOfLines = 0;
        conBottomBack.addSubview(conLabel2)

        backImgView.addSubview(selBtn)
        backImgView.addSubview(ritchTextView)
        
        backImgView.addSubview(self.delBtn)
//        backImgView.addSubview(self.photoBtn)
        
        return backImgView
    }()
    
    lazy var selBtn: UIButton = {
        let selBtn = UIButton.init(frame: CGRectMake(32.px(), 395.px(), 25.px(), 25.px()))
        selBtn.setImage(UIImage(named: "Loginicon_singin_unselected"), for: .normal)
        selBtn.isSelected = false;
        selBtn.addTarget(self, action: #selector(popSelAction), for: .touchUpInside)
        return selBtn
    }()
    
    lazy var ritchTextView: UILabel = {
        
        let ritchTextView = UILabel(frame: CGRectMake(71.px(), 388.px(), 350.px(), 40.px()))
      
//        ritchTextView.isEditable = false;
//        ritchTextView.isScrollEnabled = false;
        ritchTextView.backgroundColor = UIColor.clear

        let totlaStr = "Read and agree with the above terms.";
//        let normalStr = "Read and consent to the ";
//        let ppStr = "Privacy Policy.";
//
//        let attributedString = NSMutableAttributedString.init(string: "Read and consent to the Privacy Policy.")
//
//
//        attributedString.addAttributes([NSAttributedString.Key.link : "pp://"], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (ppStr as NSString) as String).first!)
//
//        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (normalStr as NSString) as String).first!)
//
//
//        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#3EA636"), NSMutableAttributedString.Key.underlineColor : UIColor.init("#3EA636"), NSMutableAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue],   range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (ppStr as NSString) as String).first!)
//
//
//        ritchTextView.attributedText = attributedString
//
//        ritchTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init("#3EA636")];
        ritchTextView.text = totlaStr
        ritchTextView.textColor = UIColor.init("#DDAE02")
        ritchTextView.font = UIFont(name: kOSRegular, size: 18.px())
        
        return ritchTextView;
        
        
    }()
    
 
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), kIsNotchScreen ? (CGRectGetMinY(self.backImgView.frame) - 35.px()) : (CGRectGetMinY(self.backImgView.frame) + 10.px()), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return closeBtn
        
    }()
    

    
    lazy var delBtn:UIButton = {
        let delBtn = UIButton(type: .custom)
        delBtn.frame = CGRectMake(17.px(), 440.px(), 341.px(), 50.px())
        delBtn.layer.masksToBounds = true
        delBtn.layer.cornerRadius = 15.px()
        
        delBtn.backgroundColor = UIColor.white
        delBtn.setTitle("Delete account", for: .normal)
        delBtn.setTitleColor(UIColor.init("#FF5D00"), for: .normal)
        delBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        delBtn.addTarget(self, action: #selector(delBtnAction), for: .touchUpInside)
        return delBtn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha:0.6)
        self.addSubview(self.backImgView)
        self.addSubview(self.conView)
        self.addSubview(self.closeBtn)
        
        
        
    }
    
    @objc func closeBtnAction(){
        self.removeFromSuperview()
        
        
    }
    
       @objc func delBtnAction (){
           
           if (!self.selBtn.isSelected){
               AppClassUtilsHelper.makeTopHudidAction(str: "Please check the agree terms")
               return
           }
           
           self.removeFromSuperview()
           self.selBlock!()
       }
    
    func selblockAction(block: @escaping LogOffPopViewBlockClass) -> Void {
        self.selBlock = block
    }

    @objc func popSelAction (){
        self.selBtn.isSelected = !self.selBtn.isSelected
        
        if (self.selBtn.isSelected){
            selBtn.setImage(UIImage(named: "Loginicon_singin_selected"), for: .normal)

        }else{
            selBtn.setImage(UIImage(named: "Loginicon_singin_unselected"), for: .normal)

        }
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
