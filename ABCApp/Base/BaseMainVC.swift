//
//  BaseMainVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit


class BaseMainVC: BaseVC {
    
    lazy var tabView : UIView = {
        
        let tabView = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight - CGFloat(kCustomTabBarHeight), width: kScreenWidth, height: CGFloat(kCustomTabBarHeight)))
        tabView.backgroundColor = UIColor.init("#FFF4CC")
        
//        let lineView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 1.px()))
//        lineView.backgroundColor = UIColor.init("#E7E7E7")
//        tabView.addSubview(lineView)
        
        return tabView
    }()
    
    lazy var left1View:RootTabBarItem = {
        
        let view = RootTabBarItem.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth / 4, height: CGFloat(kCustomTabBarHeight)))
        view.iconImg.image = UIImage.init(named: "icon_home_unselected")
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selTab1Action)))
        view.titleLabel.text = "Home"
        return view
        
    }()
    

    
    lazy var left2View:RootTabBarItem = {
        
        let view = RootTabBarItem.init(frame: CGRect.init(x: kScreenWidth / 4, y: 0, width: kScreenWidth / 4, height: CGFloat(kCustomTabBarHeight)))
        view.iconImg.image = UIImage.init(named: "icon_message_unselected")
        view.titleLabel.text = "Message"
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selTab2Action)))
        return view
        
    }()
    
    lazy var left3View:RootTabBarItem = {
        
        let view = RootTabBarItem.init(frame: CGRect.init(x: kScreenWidth / 4 * 2, y: 0, width: kScreenWidth / 4, height: CGFloat(kCustomTabBarHeight)))
        view.iconImg.image = UIImage.init(named: "icon_service_unselected")
        view.titleLabel.text = "Service"
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selTab3Action)))
        return view
        
    }()
    
    lazy var left4View:RootTabBarItem = {
        
        let view = RootTabBarItem.init(frame: CGRect.init(x: kScreenWidth / 4 * 3, y: 0, width: kScreenWidth / 4, height: CGFloat(kCustomTabBarHeight)))
        view.iconImg.image = UIImage.init(named: "icon_profile_unselected")
        view.titleLabel.text = "Profile"
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selTab4Action)))
        return view
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.view.addSubview(self.tabView)
        self.tabView.addSubview(self.left1View)
        self.tabView.addSubview(self.left2View)
        self.tabView.addSubview(self.left3View)
        self.tabView.addSubview(self.left4View)
        self.addTopImgView()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func selTab1Action(){
        
        self.tabBarController?.selectedIndex = 0
        self.shakeToShow()
    }
    @objc func selTab2Action(){
        

        guard let sessionStr = AppClassUtilsHelper.getUserDefault(key: sessionUser), let conSessionStr:String = sessionStr as? String, conSessionStr.count > 0 else {
            let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
            loginView.selblockSuccessAction(block: { [weak self] in
                                                          
                let navi = self?.tabBarController?.children.first as! BaseNC
                let homeVC = navi.children.first as! HomeVC
                homeVC.getAppHomeBigDataAction()
                homeVC.startLocationAction()
            })
            self.view.addSubview(loginView)
            return
        }
        
        
        self.tabBarController?.selectedIndex = 1
        self.shakeToShow()
    }
    
    @objc func selTab3Action(){
        
        guard let sessionStr = AppClassUtilsHelper.getUserDefault(key: sessionUser), let conSessionStr:String = sessionStr as? String, conSessionStr.count > 0 else {
            let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
            loginView.selblockSuccessAction(block: { [weak self] in
                let navi = self?.tabBarController?.children.first as! BaseNC
                let homeVC = navi.children.first as! HomeVC
                homeVC.getAppHomeBigDataAction()
                homeVC.startLocationAction()
            })
            self.view.addSubview(loginView)
            return
        }
        self.tabBarController?.selectedIndex = 2
        self.shakeToShow()
    }
    
    @objc func selTab4Action(){
        
        guard let sessionStr = AppClassUtilsHelper.getUserDefault(key: sessionUser), let conSessionStr:String = sessionStr as? String, conSessionStr.count > 0 else {
            let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
            loginView.selblockSuccessAction(block: { [weak self] in
                let navi = self?.tabBarController?.children.first as! BaseNC
                let homeVC = navi.children.first as! HomeVC
                homeVC.getAppHomeBigDataAction()
                homeVC.startLocationAction()
            })
            self.view.addSubview(loginView)
            return
        }
        self.tabBarController?.selectedIndex = 3
        self.shakeToShow()
    }
    
    
    
    func shakeToShow() {
        
        let nc =  self.tabBarController?.children[self.tabBarController?.selectedIndex ?? 0] as! BaseNC
        let vc = nc.children.first as! BaseMainVC;
        
        if (self.tabBarController?.selectedIndex == 1){
            makeAnimation(aView: vc.left2View)
        }else if (self.tabBarController?.selectedIndex == 2){
            makeAnimation(aView: vc.left3View)
        }else if (self.tabBarController?.selectedIndex == 3){
            makeAnimation(aView: vc.left4View)
        }else if (self.tabBarController?.selectedIndex == 0){
            makeAnimation(aView: vc.left1View)
        }
        
        
     
    }

    func makeAnimation (aView: UIView){
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.3 // 动画时间
        var values = [CATransform3D]()
        // 前两个是控制view的大小的；
        values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        values.append(CATransform3DMakeScale(0.8, 0.8, 1.0))
        values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        animation.values = values
        aView.layer.add(animation, forKey: nil)
    }
    
}
