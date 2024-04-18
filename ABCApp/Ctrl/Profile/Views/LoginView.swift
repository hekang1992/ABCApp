//
//  LoginView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/23.
//

import UIKit

typealias LoginViewSelSuccBlock = () -> ()

class LoginView: UIView, UITextViewDelegate {
    
    var loginBlock: LoginViewSelSuccBlock?
    
    
    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 477.px(), kScreenWidth, 477.px()))
        backImgView.image = UIImage(named: "Loginbg_signin")
        backImgView.isUserInteractionEnabled = true
        backImgView.addSubview(self.phoneTF)
        backImgView.addSubview(self.codeTF)
        backImgView.addSubview(self.selBtn)
        backImgView.addSubview(self.ritchTextView)
        
        backImgView.addSubview(self.signBtn)
        return backImgView
    }()
    
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), CGRectGetMinY(self.backImgView.frame) - 35.px(), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeBtn
        
    }()
    
    lazy var phoneTF : UITextField = {
        
        let phoneTF = UITextField.init(frame: CGRectMake(16.px(), 156.px(), 341.px(), 50.px()))
        phoneTF.layer.masksToBounds = true
        phoneTF.layer.cornerRadius = 15.px()
        phoneTF.backgroundColor = UIColor.white
        phoneTF.textColor = UIColor.init("#DDAE02")
        phoneTF.leftViewMode = .always
        phoneTF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        phoneTF.keyboardType = .numberPad
        phoneTF.rightViewMode = .always
        phoneTF.leftViewMode = .always
        let leftView = UIView(frame: CGRectMake(0, 0, 50.px(), 50.px()))
        let label = UILabel(frame: CGRectMake(0, 0, 50.px(), 50.px()))
        label.text = "+63"
        label.textAlignment = .center
        label.font = UIFont(name: kOSRegular, size: 18.px())
        leftView.addSubview(label)
        phoneTF.leftView = leftView
        //        phoneTF.text = "9742645768"
        let rightView  = UIView(frame: CGRectMake(0, 0, 41.px(), 50.px()))
        
        let conImgView = UIImageView(frame: CGRectMake(0, 19.px(), 13.px(), 13.px()))
        conImgView.image = UIImage(named: "Loginicon_input_cancel")
        conImgView.isUserInteractionEnabled = true
        conImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearPhoneAction)))
        rightView.addSubview(conImgView)
        
        phoneTF.rightView = rightView
        phoneTF.attributedPlaceholder = NSAttributedString.init(string:"Mobile number", attributes: [NSAttributedString.Key.font:UIFont.init(name: kOSRegular, size: 18.px())!, NSAttributedString.Key.foregroundColor:UIColor.init("#DDAE02")])
        phoneTF.font = UIFont.init(name: kOSRegular, size: 18.px())
        
        
        
        return phoneTF
        
    }()
    
    lazy var codeTF : UITextField = {
        
        let codeTF = UITextField.init(frame: CGRectMake(16.px(), 249.px(), 341.px(), 50.px()))
        codeTF.layer.masksToBounds = true
        codeTF.layer.cornerRadius = 15.px()
        codeTF.backgroundColor = UIColor.white
        codeTF.textColor = UIColor.init("#DDAE02")
        codeTF.leftViewMode = .always
        codeTF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        codeTF.keyboardType = .numberPad
        codeTF.rightViewMode = .always
        codeTF.font =  UIFont.init(name: kOSRegular, size: 18.px())
        let rightView  = UIView(frame: CGRectMake(0, 0, 69.px(), 50.px()))
        
        rightView.addSubview(AppCacheHelper.sharedInstance.codeBtn)
        
        AppCacheHelper.sharedInstance.selBtnBlockAction{
            print("geycode")
            
            if (self.phoneTF.text?.count == 0){
                AppClassUtilsHelper.makeTopHudidAction(str: "Please enter a mobile");
                return
            }
            
            //            let mobileParams:[String:String] = ["stagger":self.phoneTF.text!, "carrying": AppClassUtilsHelper.getRandomeStrAction(count: 10)]
            
            let mobileParams:[String:String] = ["stagger":self.phoneTF.text!, "carrying": AppClassUtilsHelper.getRandomeStrAction(count: 10)]
            
            
            let getCodeTime = DeviceInfoManager.getCurrentMillis();
            AppClassUtilsHelper.saveUserDefault(value: getCodeTime, key: GetCodetTimeKey)
            
            AppNetHelper.post_uprightFingersAction(params: mobileParams) { resSucc in
                AppClassUtilsHelper.makeTopHudidAction(str: "Send verification code success");
                AppCacheHelper.sharedInstance.codeBtn.startCountDown()
            } fail: { resFail in
                //                AppCacheHelper.sharedInstance.codeBtn.startCountDown()
            }
            
            
        }
        
        rightView.backgroundColor = UIColor.white
        
        codeTF.rightView = rightView
        codeTF.attributedPlaceholder = NSAttributedString.init(string:"Please enter the verification code", attributes: [NSAttributedString.Key.font:UIFont.init(name: kOSRegular, size: 18.px())!, NSAttributedString.Key.foregroundColor:UIColor.init("#DDAE02")])
        
        
        return codeTF
        
    }()
    
    lazy var selBtn: UIButton = {
        let selBtn = UIButton.init(frame: CGRectMake(20.px(), CGRectGetMaxY(self.codeTF.frame) + 45.px(), 25.px(), 25.px()))
        selBtn.setImage(UIImage(named: "Loginicon_singin_selected"), for: .normal)
        selBtn.isSelected = true;
        selBtn.addTarget(self, action: #selector(popSelAction), for: .touchUpInside)
        return selBtn
    }()
    
    lazy var ritchTextView: UITextView = {
        
        let ritchTextView = UITextView(frame: CGRectMake(45.px(), CGRectGetMaxY(self.codeTF.frame) + 38.px(), 350.px(), 40.px()))
        ritchTextView.delegate = self;
        ritchTextView.isEditable = false;
        ritchTextView.isScrollEnabled = false;
        ritchTextView.backgroundColor = UIColor.clear
        
        let totlaStr = "Read and consent to the Privacy Policy.";
        let normalStr = "Read and consent to the ";
        let ppStr = "Privacy Policy.";
        
        let attributedString = NSMutableAttributedString.init(string: "Read and consent to the Privacy Policy.")
        
        
        attributedString.addAttributes([NSAttributedString.Key.link : "pp://"], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (ppStr as NSString) as String).first!)
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (normalStr as NSString) as String).first!)
        
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#3EA636"), NSMutableAttributedString.Key.underlineColor : UIColor.init("#3EA636"), NSMutableAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue],   range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (ppStr as NSString) as String).first!)
        
        
        ritchTextView.attributedText = attributedString
        
        ritchTextView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init("#3EA636")];
        
        ritchTextView.font = UIFont(name: kOSRegular, size: 20.px())
        
        return ritchTextView;
        
        
    }()
    
    lazy var signBtn: UIButton = {
        let signBtn = UIButton.init(frame: CGRectMake(16.px(), CGRectGetMaxY(self.codeTF.frame) + 100.px(), 341.px(), 50.px()))
        signBtn.backgroundColor = UIColor.init("#299F2D")
        signBtn.layer.masksToBounds = true;
        signBtn.layer.cornerRadius = 15.px()
        
        signBtn.setTitle("Sign In", for: .normal)
        signBtn.setTitleColor(UIColor.white, for: .normal)
        signBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        signBtn.addTarget(self, action: #selector(signAction), for: .touchUpInside)
        return signBtn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha:0.6)
        self.addSubview(self.backImgView)
        self.addSubview(self.closeBtn)
        
    }
    
    @objc func signAction(){
        
        if (self.phoneTF.text?.count == 0){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please enter a mobile");
            return
        }
        
        if (self.codeTF.text?.count == 0){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please enter a code");
            return
        }
        
        if (!self.selBtn.isSelected){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please check the Privacy Policy.")
            return
        }
        
        
        var postParams:[String:String] = [
            "merry":self.phoneTF.text!,
            //            "merry":self.codeTF.text,
            "speeches":self.codeTF.text!,
            "partner":AppClassUtilsHelper.getRandomeStrAction(count: 10)
        ]
        
        AppNetHelper.post_thoughtEveryoneAction(params: postParams) { succ in
            
            let data:Dictionary =  succ.mcneil as! [String:Any]
            let session:String = data["nobody"] as! String
            let mobile:String = data["merry"] as! String
            
            let loginTime = DeviceInfoManager.getCurrentMillis();
            AppClassUtilsHelper.saveUserDefault(value: loginTime, key: LoginSuccessKey)
            AppClassUtilsHelper.saveUserDefault(value: loginTime, key: LoginSuccessTime)
            
            AppClassUtilsHelper.saveUserDefault(value: session, key: sessionUser)
            AppClassUtilsHelper.saveUserDefault(value: mobile, key: mobileUser)
            AppCacheHelper.sharedInstance.isPostDevice = 0
            AppCacheHelper.sharedInstance.isPostLocation = 0
            
            self.loginSuccessAction()
            
            self.removeFromSuperview()
            
            print("success")
            
            // 保存手机号
            // 保存session
            
        } fail: { fail in
            print("fail")
        }
        
    }
    
    func loginSuccessAction (){
        self.loginBlock!()
    }
    
    func selblockSuccessAction(block: @escaping LoginViewSelSuccBlock) -> Void {
        self.loginBlock = block
    }
    
    
    @objc func closeAction (){
        self.removeFromSuperview()
    }
    @objc func clearPhoneAction (){
        self.phoneTF.text = "";
    }
    
    @objc func popSelAction (){
        self.selBtn.isSelected = !self.selBtn.isSelected
        
        if (self.selBtn.isSelected){
            selBtn.setImage(UIImage(named: "Loginicon_singin_selected"), for: .normal)
            
        }else{
            selBtn.setImage(UIImage(named: "Loginicon_singin_unselected"), for: .normal)
            
        }
    }
    
    public class func rangeOfString(string:NSString,
                                    andInString inString:String) -> [NSRange] {
        
        var arrRange = [NSRange]()
        var _fullText = string
        var rang:NSRange = _fullText.range(of: inString)
        
        while rang.location != NSNotFound {
            var location:Int = 0
            if arrRange.count > 0 {
                if arrRange.last!.location + arrRange.last!.length <= string.length {
                    location = arrRange.last!.location + arrRange.last!.length
                }
            }
            
            _fullText = NSString.init(string: _fullText.substring(from: rang.location + rang.length))
            
            if arrRange.count > 0 {
                rang.location += location
            }
            arrRange.append(rang)
            
            rang = _fullText.range(of: inString)
        }
        
        return arrRange
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "pp"{
            let paramsStr = AppAFNetManager.getPublicParamsAction()
            let webVC = AppWebViewVC()
            webVC.urlStr = PPURL + "?" + paramsStr
            self.currentNavViewController()?.pushViewController(webVC, animated: true)
        }
        
        return true
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
