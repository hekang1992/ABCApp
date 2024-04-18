//
//  LogOutView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

typealias LogOutViewBlockClass = () -> ()


class LogOutView: UIView {
    
    var selBlock:LogOutViewBlockClass?
    
    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 110.px() - 245.px(), kScreenWidth, 110.px()))
        backImgView.image = UIImage(named: "bg_idconfirm")
        backImgView.isUserInteractionEnabled = true
        
        return backImgView
    }()
    
    lazy var conView : UIView = {
        let conView = UIView(frame: CGRectMake(0, kScreenHeight - 245.px(), kScreenWidth, 245.px()))
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = conView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        conView.layer.addSublayer(bgLayer1)
        
      
        
        let conBottomBack = UIView(frame: CGRectMake(17.px(), 20.px(), 341.px(), 105.px()))
        conBottomBack.backgroundColor = UIColor.white
        conBottomBack.layer.masksToBounds = true
        conBottomBack.layer.cornerRadius = 15.px()
        conView.addSubview(conBottomBack)
        
        let conLabel2 = UILabel(frame: CGRectMake(15.px(), 0, 311.px(), 105.px()))
        conLabel2.text = "Are you sure you want to sign out?\nAfter signing out, you won't have access to track your order progress.."
        conLabel2.textColor = UIColor.init("#263738")
        conLabel2.font = UIFont(name: kOSRegular, size: 18.px())
        conLabel2.numberOfLines = 0;
        conBottomBack.addSubview(conLabel2)

     
        
        conView.addSubview(self.delBtn)
//        backImgView.addSubview(self.photoBtn)
        
        return conView
    }()
    
  
    
 
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), (CGRectGetMinY(self.backImgView.frame) - 35.px()), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return closeBtn
        
    }()
    

    
    lazy var delBtn:UIButton = {
        let delBtn = UIButton(type: .custom)
        delBtn.frame = CGRectMake(17.px(), 155.px(), 341.px(), 50.px())
        delBtn.layer.masksToBounds = true
        delBtn.layer.cornerRadius = 15.px()
        
        delBtn.backgroundColor = UIColor.init("#299F2D")
        delBtn.setTitle("Sign out", for: .normal)
        delBtn.setTitleColor(UIColor.white, for: .normal)
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
        self.removeFromSuperview()
        self.selBlock!()
    }
    
    
    func selblockAction(block: @escaping LogOffPopViewBlockClass) -> Void {
        self.selBlock = block
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
