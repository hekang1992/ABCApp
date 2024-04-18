//
//  BaseVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

class BaseVC: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate
{

    var _boolIsShowNavigation:Bool?
    var _isCanSideBack : Bool = true;
    lazy var baseBackBtn : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: 10.px(), y: CGFloat(kStatusHeight) + 22 - 17.px(), width: 35.px(), height: 35.px())
        btn.isHidden = true
        btn.setImage(UIImage.init(named: "icon_yanzheg_back"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(backClick), for: UIControl.Event.touchUpInside)
        return btn;
    }()

    lazy var titlelabel : UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.init(name: kOSRegular, size: 24.px())
        label.textColor = UIColor.init("#263738")
        label.isHidden = true
        label.frame = CGRect.init(x: kScreenWidth / 2 - 140.px(), y: CGFloat(kStatusHeight) + 22 - 15.px(), width: 280.px(), height: 30.px())
//        label.layer.zPosition = 15
        return label
    }()
    
    lazy var topImgView : UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height:CGFloat(kNavigationBarHeight))
        imgView.image = UIImage.init(named: "main_top")
        imgView.contentMode =  UIView.ContentMode.scaleToFill
        imgView.isHidden = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        _boolIsShowNavigation = false;  
        self.navigationController?.delegate = self;
        if (self.navigationController?.viewControllers[0] == self) {
            self.forbiddenSideBack()
        }else{
            self.resetSideBack()
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.view.endEditing(true);
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init("#FFFFFF")

        self.view.addSubview(self.topImgView)
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
        
    }
    
    func setupViews(){
        
    }
    
    func setupConstraints(){
        
    }
    
    func addBackBtnAction (){
        self.view.addSubview(self.baseBackBtn)
        self.baseBackBtn.isHidden = false
    }
    
    func addTitleLabelAction(){
        self.view.addSubview(self.titlelabel)
        self.titlelabel.isHidden = false
    }
    
    func addTopImgView(){
        self.topImgView.isHidden = false
    }

    @objc func backClick() {
        self.navigationController?.popViewController(animated: true);
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    /**
     * 禁用边缘返回
     */
    func forbiddenSideBack() {
        _isCanSideBack = false;
        self.makeInteractivePopGestureRecognizer(obj: self)
    }
    
    /**
     * 恢复边缘返回
     */
    func resetSideBack() {
        _isCanSideBack = true
        self.makeInteractivePopGestureRecognizer(obj: [:])
    }
    
    func makeInteractivePopGestureRecognizer(obj:Any) {
        
        if ((self.navigationController?.responds(to:NSSelectorFromString("interactivePopGestureRecognizer"))) ?? true) {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = obj as? UIGestureRecognizerDelegate;
        }
    }
    
    func gestureRecognizerShouldBegin() -> Bool {
        
        return _isCanSideBack
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.navigationController?.setNavigationBarHidden(!(_boolIsShowNavigation ?? true), animated: true)
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

