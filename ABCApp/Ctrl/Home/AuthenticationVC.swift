//
//  AuthenticationVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit
import HandyJSON

class AuthenticationVC: BaseVC {

    var productId:String = "";
    
    lazy var conScrollowView : UIScrollView = {
        
        let conScrollowView = UIScrollView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight))
        conScrollowView.contentSize = CGSize(width: kScreenWidth, height: 828.px() + 136.px())
        conScrollowView.showsVerticalScrollIndicator = false
        
        let topImgView = UIImageView(image: UIImage(named: "bg_yanzheng"))
        topImgView.frame = CGRectMake(0, 0, kScreenWidth, 136.px())
        conScrollowView.addSubview(topImgView)
        conScrollowView .addSubview(self.scrollowBackView)
        conScrollowView.backgroundColor = UIColor.clear
        return conScrollowView
    }()
    
    lazy var scrollowBackView : UIView = {
        
        let scrollowBackView = UIView(frame: CGRectMake(0, 136.px(), kScreenWidth, 828.px()))
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = scrollowBackView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        scrollowBackView.layer.addSublayer(bgLayer1)
        
        
        let bg_step1 = UIImageView(image: UIImage(named: "bg_step1"))
        bg_step1.frame = CGRectMake(66.px(), -90.px(), 106.px(), 264.px())
        scrollowBackView.addSubview(bg_step1)
        
        scrollowBackView.addSubview(self.step1BgView)
        
        scrollowBackView.addSubview(self.step2BgView)
        
        let bg_step2 = UIImageView(image: UIImage(named: "bg_step3"))
        bg_step2.frame = CGRectMake(58.px(),CGRectGetMaxY(self.step2BgView.frame) + 34.px(), 121.px(), 70.px())
        scrollowBackView.addSubview(bg_step2)
        
        scrollowBackView.addSubview(self.step3BgView)
        
        scrollowBackView.addSubview(self.nextImgView)
        
        let bottomImg = UIImageView(image: UIImage(named: "bg2_renzheng"))
        bottomImg.frame = CGRectMake(0,702.px(), kScreenWidth, 126.px())
        scrollowBackView.addSubview(bottomImg)
        
        
        
        return scrollowBackView
    }()
    
    lazy var step1BgView:UIView = {
        
        let step1BgView = UIView(frame: CGRectMake(35.px(), -28.px(), 280.px(), 140.px()))
        step1BgView.backgroundColor = UIColor.init("#FFF4CC")
        step1BgView.layer.masksToBounds = true
        step1BgView.layer.cornerRadius = 15.px()
        
        step1BgView.transform = CGAffineTransformMakeRotation(M_PI/180 * 4);
        
        let step1Label = UILabel(frame: CGRectMake(10.px(), 20.px(), 250.px(), 22.px()))
        step1Label.text = "1. ID Card and Facial Verification"
        step1Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step1Label.textColor = UIColor.init("#299F2D")
        step1BgView.addSubview(step1Label)
        
        step1BgView.addSubview(step1LeftImgView)
        step1BgView.addSubview(step1RightImgView)
        step1BgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(idverificationAction)))
        
        
        return step1BgView
        
    }()
    
    lazy var step1LeftImgView: UIImageView = {
        
        let step1LeftImgView = UIImageView(image: UIImage(named: "icon_camera"))
        step1LeftImgView.frame = CGRectMake(15.px(), 52.px(), 120.px(), 73.px())
        step1LeftImgView.layer.masksToBounds = true
        step1LeftImgView.layer.cornerRadius = 15.px()
        return step1LeftImgView
    }()
    
    lazy var step1RightImgView: UIImageView = {
        
        let step1RightImgView = UIImageView(image: UIImage(named: "icon_faceid"))
        step1RightImgView.frame = CGRectMake(145.px(), 52.px(), 120.px(), 73.px())
        step1RightImgView.layer.masksToBounds = true
        step1RightImgView.layer.cornerRadius = 15.px()
        return step1RightImgView
    }()
    
    
    
    lazy var step2BgView:UIView = {
        
        let step2BgView = UIView(frame: CGRectMake(77.px(),CGRectGetMaxY(self.step1BgView.frame) + 71.px(), 262.px(), 176.px()))
        step2BgView.backgroundColor = UIColor.init("#FFF4CC")
//        step2BgView.layer.masksToBounds = true
        step2BgView.layer.cornerRadius = 15.px()
        
        step2BgView.transform = CGAffineTransformMakeRotation(M_PI/180 * -2);
        
        let bg_step2 = UIImageView(image: UIImage(named: "bg_step2"))
        bg_step2.frame = CGRectMake(139.px(), -34.px(), 123.px(), 76.px())
        step2BgView.addSubview(bg_step2)
        
        let step2Label = UILabel(frame: CGRectMake(10.px(), 0.px(), 241.px(), 90.px()))
        step2Label.text = "2. Finish filling out your personal details, work information, and contact details"
        step2Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step2Label.textColor = UIColor.init("#299F2D")
        step2Label.numberOfLines = 0
        step2BgView.addSubview(step2Label)
        
        step2BgView.addSubview(step2Label1)
        step2BgView.addSubview(step2Label2)
        step2BgView.addSubview(step2Label3)
        
        return step2BgView
        
    }()
    
    
    lazy var step2Label1:UILabel = {
        let step2Label1 = UILabel(frame: CGRectMake(15.px(), 85.px(), 230.px(), 33.px()))
        step2Label1.layer.cornerRadius = 10.px()
        step2Label1.layer.masksToBounds = true
        step2Label1.textAlignment = .center
        step2Label1.font = UIFont.init(name: kOSRegular, size: 18.px())
        step2Label1.textColor = UIColor.init("#DDAE02")
        step2Label1.text = "Personal information"
        step2Label1.backgroundColor  = UIColor.white
        step2Label1.isUserInteractionEnabled = true
        step2Label1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(personalAction)))

        return step2Label1
        
    }()
    
    lazy var step2Label2:UILabel = {
        let step2Label2 = UILabel(frame: CGRectMake(15.px(), 127.px(), 111.px(), 33.px()))
        step2Label2.layer.cornerRadius = 10.px()
        step2Label2.layer.masksToBounds = true
        step2Label2.textAlignment = .center
        step2Label2.font = UIFont.init(name: kOSRegular, size: 18.px())
        step2Label2.textColor = UIColor.init("#DDAE02")
        step2Label2.text = "Work Info"
        step2Label2 .backgroundColor  = UIColor.white
        step2Label2.isUserInteractionEnabled = true
        step2Label2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(workInfoAction)))
        return step2Label2
    }()
    
    lazy var step2Label3:UILabel = {
        let step2Label3 = UILabel(frame: CGRectMake(135.px(), 127.px(), 111.px(), 33.px()))
        step2Label3.layer.cornerRadius = 10.px()
        step2Label3.layer.masksToBounds = true
        step2Label3.textAlignment = .center
        step2Label3.font = UIFont.init(name: kOSRegular, size: 18.px())
        step2Label3.textColor = UIColor.init("#DDAE02")
        step2Label3.text = "Contact Info"
        step2Label3.backgroundColor  = UIColor.white
        step2Label3.isUserInteractionEnabled = true
        step2Label3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contactInfoAction)))
        return step2Label3
    }()
    
    
    lazy var step3BgView:UIView = {
        
        let step3BgView = UIView(frame: CGRectMake(35.px(),CGRectGetMaxY(self.step2BgView.frame) + 59.px(), 280.px(), 140.px()))
        step3BgView.backgroundColor = UIColor.init("#FFF4CC")
//        step2BgView.layer.masksToBounds = true
        step3BgView.layer.cornerRadius = 15.px()
        
        let bg_step2 = UIImageView(image: UIImage(named: "bg_2-3"))
        bg_step2.frame = CGRectMake(202.px(), -66.px(), 79.px(), 81.px())
        step3BgView.addSubview(bg_step2)
        
        let step3Label = UILabel(frame: CGRectMake(10.px(), 20.px(), 250.px(), 22.px()))
        step3Label.text = "3. Fill in Receiving Account Details"
        step3Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step3Label.textColor = UIColor.init("#299F2D")
        step3BgView.addSubview(step3Label)
        
        
        step3BgView.addSubview(step3LeftImgView)
        step3BgView.addSubview(step3RightImgView)
        
        step3BgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(walletInfoAction)))
        
        return step3BgView
        
    }()
    
    lazy var step3LeftImgView: UIImageView = {
        
        let step3LeftImgView = UIImageView(image: UIImage(named: "image_bank"))
        step3LeftImgView.frame = CGRectMake(15.px(), 52.px(), 120.px(), 73.px())
        step3LeftImgView.layer.masksToBounds = true
        step3LeftImgView.layer.cornerRadius = 15.px()
        return step3LeftImgView
    }()
    
    lazy var step3RightImgView: UIImageView = {
        
        let step3RightImgView = UIImageView(image: UIImage(named: "image_ewallet"))
        step3RightImgView.frame = CGRectMake(145.px(), 52.px(), 120.px(), 73.px())
        step3RightImgView.layer.masksToBounds = true
        step3RightImgView.layer.cornerRadius = 15.px()
        return step3RightImgView
    }()
    
    
    
    
    lazy var nextImgView:UIImageView = {
        
        let nextImgView = UIImageView(frame: CGRectMake(90.px(),CGRectGetMaxY(self.step3BgView.frame) + 1.px(), 250.px(), 156.px()))
        nextImgView.image = UIImage(named: "Slice 3")
        
//        nextImgView.addSubview(nextLabel)
        
        nextImgView.isUserInteractionEnabled = true;
        nextImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextAction)))
        
        return nextImgView
        
    }()
    
    lazy var nextLabel:UILabel = {
        let nextLabel = UILabel(frame: CGRectMake(0, 62.px(), 250.px(), 45.px()))
        nextLabel.text = "Let's get started"
        nextLabel.textColor = UIColor.white
        nextLabel.textAlignment = .center
        nextLabel.font = UIFont(name: kOSBold, size: 32.px())
        nextLabel.isUserInteractionEnabled = true;
        nextLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextAction)))
        return nextLabel
    }()
    
    var detailModel :ProductModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let paramsDic = [
            "campaign":self.productId,
            "wavered":AppClassUtilsHelper.getRandomeStrAction(count: 3),
            "fortieth":AppClassUtilsHelper.getRandomeStrAction(count: 6)
            
        ]
        
        AppNetHelper.post_weveAreAction(params: paramsDic) { succ in

            let conDic = succ.mcneil as! [String:Any]
            let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            self.detailModel = detailModel;
            
            print(detailModel);
            
//            if  ((detailModel?.judge?.isEmpty) == nil) {
//                self.followUpOrderNumber()
//            }
        } fail: { fail in
            
        }
    }
    
    
    private func followUpOrderNumber() {
        let paramsSource:[String:String] = [
            "smelled":detailModel?.concern?.toying ?? "",
            "violation":AppClassUtilsHelper.getRandomeStrAction(count: 3),
            "clouding":AppClassUtilsHelper.getRandomeStrAction(count: 6),
            "brutal":AppClassUtilsHelper.getRandomeStrAction(count: 6),
            "assault":AppClassUtilsHelper.getRandomeStrAction(count: 6)
        ]
        AppNetHelper.post_angleCrowdsAction(params: paramsSource) { succ in
            print("111")
            let conDic = succ.mcneil as! [String:Any]
            let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            AppLaunchUtils.jumpNextVCAction(rootVC: self, route: detailModel?.giving ?? "")
            
        } fail: { fail in
            print("222")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 290.px()))
        bgView.backgroundColor = UIColor.init("#FFF2E0")
        self.view.addSubview(bgView)
        
        self.view.addSubview(self.conScrollowView)
        
        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "Authentication"
            
        
        // Do any additional setup after loading the view.
    }
    @objc func nextAction (){
        
        let paramsDic = [
            "campaign":self.productId,
            "wavered":AppClassUtilsHelper.getRandomeStrAction(count: 3),
            "fortieth":AppClassUtilsHelper.getRandomeStrAction(count: 6)
            
        ]
        
        AppNetHelper.post_weveAreAction(params: paramsDic) { succ in

            let conDic = succ.mcneil as! [String:Any]
            let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            
            if (detailModel?.honestly?.decide == "33" || detailModel?.honestly?.decide == "44" || detailModel?.honestly?.decide == "55" || detailModel?.honestly?.decide == "66" || detailModel?.honestly?.decide == "77"){
                
                AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: self.productId, order: detailModel?.concern?.toying ?? "")
                
            }else{
                
                let paramsSource:[String:String] = [
                    "smelled":detailModel?.concern?.toying ?? "",
                    "violation":AppClassUtilsHelper.getRandomeStrAction(count: 3),
                    "clouding":AppClassUtilsHelper.getRandomeStrAction(count: 6),
                    "brutal":AppClassUtilsHelper.getRandomeStrAction(count: 6),
                    "assault":AppClassUtilsHelper.getRandomeStrAction(count: 6)
                ]
                AppNetHelper.post_angleCrowdsAction(params: paramsSource) { succ in
                    print("111")
                    let conDic = succ.mcneil as! [String:Any]
                    let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                    AppLaunchUtils.jumpNextVCAction(rootVC: self, route: detailModel?.giving ?? "")
                    
                } fail: { fail in
                    print("222")
                }
                
            }
            
            
        } fail: { fail in
            
        }

        

        
    }
    
    @objc func idverificationAction (){
           
        guard let conModel = self.detailModel?.tornado.first, let pause = conModel.pause, pause == "1"  else {
            self.nextAction()
            return
        }
        

        let vc = IDVerificationVC()
        vc.productId = self.productId;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func personalAction (){
            
        guard let conModel = self.detailModel?.tornado[1], let pause = conModel.pause, pause == "1"  else {
             self.nextAction()
            return
        }
        
        let vc = PersonalInfoVC()
        vc.productId = self.productId;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func workInfoAction (){
                
        guard let conModel = self.detailModel?.tornado[2], let pause = conModel.pause, pause == "1"  else {
            self.nextAction()
            return
        }
        let vc = WorkInformationVC()
        vc.productId = self.productId;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func contactInfoAction (){
                
        guard let conModel = self.detailModel?.tornado[3], let pause = conModel.pause, pause == "1"  else {
            self.nextAction()
            return
        }
        
        let vc = EmergencyContactVC()
        vc.productId = self.productId;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func walletInfoAction (){
             
        guard let conModel = self.detailModel?.tornado[4], let pause = conModel.pause, pause == "1"  else {
            self.nextAction()
            return
        }
        
        let vc = E_walletBankCardVC()
        vc.productId = self.productId;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
