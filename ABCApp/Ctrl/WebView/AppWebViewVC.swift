//
//  AppWebViewVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/22.
//

import UIKit
import WebKit
import StoreKit
import SVProgressHUD
import HandyJSON

class AppWebViewVC: BaseMainVC, WKScriptMessageHandler {

    var urlStr: String = ""
    var isScree: Int?
    var type1: String?
    
    lazy var userCtrl:WKUserContentController = {
        let userCtrl = WKUserContentController()
        
        userCtrl.add(self, name: "wavedFolder") // 风控
        userCtrl.add(self, name: "placeSheriff") //跳转原生或者H5
        userCtrl.add(self, name: "fortuneJudgment") //关闭
        userCtrl.add(self, name: "recentlyTogether") //回到 App 首页
        
        userCtrl.add(self, name: "gradualChecked") //H5 页面里的拨打电话
        userCtrl.add(self, name: "livedPlaying")  //调用 App 应用评分
        
        userCtrl.add(self, name: "Inwardly")
        userCtrl.add(self, name: "Fastidious")
        userCtrl.add(self, name: "Qualities")
        userCtrl.add(self, name: "Immediately")
        userCtrl.add(self, name: "Storytelling")
        userCtrl.add(self, name: "Griswolds")
        userCtrl.add(self, name: "couldWatched")
        
        return userCtrl;
    }()
    
    lazy var webView: WKWebView = {
        
        let  preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences;
        configuration.userContentController = self.userCtrl;
        let webView = WKWebView.init(frame: CGRect.init(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight), configuration: configuration)
        webView.backgroundColor = UIColor.white
        webView.navigationDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _boolIsShowNavigation = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBackBtnAction()
        
        self.isScree = 1;
        
        view.insertSubview(webView, belowSubview: self.baseBackBtn)
        
        addTitleLabelAction()
        
        webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
        print("web--url \(urlStr)")
    }
    
    override func backClick() {
         
         if (self.webView.canGoBack){
             self.webView.goBack()
             
         }else{

             if let navigationController = self.navigationController {
                 let viewControllers = navigationController.viewControllers
                 
                 var classArr = [String]()
                 for viewController in viewControllers {
                     let className = String(describing: type(of: viewController))
                     classArr.append(className)
                 }
                 
                 if classArr.contains("AuthenticationVC") {
                     if let index = classArr.firstIndex(of: "AuthenticationVC"), index > 0 {
                         navigationController.popToViewController(viewControllers[index - 1], animated: true)
                     }
                 } else {
                     if classArr.contains("E-walletBankCardVC") {
                         if let index = classArr.firstIndex(of: "E-walletBankCardVC"), index > 0 {
                             navigationController.popToViewController(viewControllers[index - 1], animated: true)
                         }
                     } else {
                         let mon = UserDefaults.standard.object(forKey: "mongyeF")
                         if mon as! String == "1" {
                             navigationController.popToRootViewController(animated: true)
                         }else {
                             navigationController.popViewController(animated: true)
                         }
                     }
                 }
             }
         }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let clickName = message.name;
        let obj = message.body

        if (clickName == "wavedFolder" || clickName == "Inwardly"){ //风控埋点
            
            NSLog("风控");
           
            guard let urlArray = obj as? Array<String>, let productId = urlArray.first, let startTime = urlArray.last else {
                return
            }
            let endTime:String = DeviceInfoManager.getCurrentMillis();

            let postParams:[String:String] = [
                "judicial": productId,   // 产品ID
                "triangle": "10",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": "",  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": startTime, // 开始时间
                "quicker": endTime ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 结束申贷 \(postParams)")

            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 结束申贷 成功")

            } fail: { fail in
                print("aaa  -- 上报 结束申贷 失败")

            }
            
            
        }else if (clickName == "placeSheriff" || clickName == "Fastidious"){//跳转 Scheme
            NSLog("跳转 Scheme控");

            guard let urlArray = obj as? Array<String>, let rout = urlArray.first else {
                return
            }
            
            if (rout.contains("ace://yy.ee/") == true){
                
                let routeStr = rout.replacingOccurrences(of: "ace://yy.ee/", with: "")
                
                let routeArr = routeStr.components(separatedBy: "?")
                let routeType = routeArr.first
                
                if (routeType == "noddedBreath"){
                    
                    let paramsStr = routeArr.last
                    let paramsArr = paramsStr?.components(separatedBy: "=")
                    let productId = paramsArr?.last
                    
                    let paramsDic = [
                        "campaign":productId ?? "",
                        "wavered":AppClassUtilsHelper.getRandomeStrAction(count: 3),
                        "fortieth":AppClassUtilsHelper.getRandomeStrAction(count: 6)
                        
                    ]
                    AppNetHelper.post_weveAreAction(params: paramsDic) { succ in
                        
                        let conDic = succ.mcneil as! [String:Any]
                        let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                        
                        if (detailModel?.squeaked != "200"){
                            AppLaunchUtils.jumpNextVCAction(rootVC: self, route: detailModel?.giving ?? "")
                            return
                        }
                        
                        if (detailModel?.honestly?.decide == "33" || detailModel?.honestly?.decide == "44" || detailModel?.honestly?.decide == "55" || detailModel?.honestly?.decide == "66" || detailModel?.honestly?.decide == "77"){
                            
                            AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: productId ?? "", order: detailModel?.concern?.toying ?? "")
                            
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
                    
                    
                }else{
                    AppLaunchUtils.jumpNextVCAction(rootVC: self, route: rout);

                }
                
                
            }else{
                AppLaunchUtils.jumpNextVCAction(rootVC: self, route: rout);

            }
            

            
//            let publicParamsStr = AppAFNetManager.getPublicParamsAction();
//            let urlStr = NSString(format: "%@?%@", rout, publicParamsStr) as String;
//            let webVC = AppWebViewVC();
//            webVC.urlStr = urlStr;
//            self.navigationController?.pushViewController(webVC, animated: true);
            

        }else if (clickName == "fortuneJudgment"){//关闭当前 H5
            self.navigationController?.popViewController(animated: true)
        }else if (clickName == "recentlyTogether"){
            //回到 App 首页
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            self.navigationController?.popToRootViewController(animated: false)
            appdelegate.rootTabBarVC.selectedIndex = 0
//            BaseTabBarController *tab = self.navigationController.parentViewController;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            tab.selectedIndex = 0;
//            UINavigationController *homeNC = tab.childViewControllers.firstObject;
//            HomeVC *homeVC = homeNC.childViewControllers.firstObject;
//            [homeVC setHomeBtnSel:YES];
//            [homeVC setMineBtnSel:NO];
        }else if (clickName == "gradualChecked" || clickName == "Storytelling"){ //H5 页面里的拨打电话
            
            guard let strArray = obj as? Array<String>, let url = strArray.first else {
                return
            }
            guard let url = URL(string: "tel:\(url)"), UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }else if (clickName == "livedPlaying"){ //调用 App 应用评分
            SKStoreReviewController.requestReview();
        }else if (clickName == "couldWatched"){ //是否隐藏头部导航栏  isScree1是0否 如果参数是空走默认
            changeWebViewFrame(obj: obj)
        }else if (clickName == "jumpToEmail") {//邮箱跳转
            
        }
    }

    private func changeWebViewFrame(obj: Any) {
        if let array = obj as? Array<Any>, let result = array.first {
            self.isScree = result as? Int;
            if result as! Int == 1 {
                print("111");
                self.isScree = result as? Int
                if self.type1 == "tab" {
                    self.webView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight)
                }else {
                    self.webView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                }
            }else {
                print("222");
                self.webView.frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight)
            }
        }else {
            print("333");
            self.isScree = 0;
            self.webView.frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight)
        }
        self.webView.layoutIfNeeded()
        self.webView.setNeedsLayout()
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

extension AppWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 40.0) {
            SVProgressHUD.dismiss()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        print("webview----- \(url)")

        let urlabsoluteString = url.absoluteString
        if !urlabsoluteString.hasPrefix("http") {
            UIApplication.shared.open(url, options: [:]) { success in
                if urlabsoluteString.contains("whatsapp://") {
                    if !success {
                        AppClassUtilsHelper.makeTopHudidAction(str: "Please install WhatsApp")
                    }
                }
            }

            if urlabsoluteString.contains("phonepe://pay") || urlabsoluteString.contains("paytmmp://pay") || urlabsoluteString.contains("gpay://upi/") {
                decisionHandler(.cancel)
                return
            }
        } else {
            if urlabsoluteString.contains(ApiPrefix) {
//                if isScree == 0 { // 0 不隐藏
//                    self.webView.scrollView.contentInset = UIEdgeInsets(top: kNavigationBarHeight, left: 0, bottom: 0, right: 0);
//                } else { // 1 隐藏
//                    self.webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
//                }
//                if urlabsoluteString.contains(PPURL) || urlabsoluteString.contains(PPURL) {
//                    self.webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
//                }
            } else {
                self.webView.scrollView.contentInset = UIEdgeInsets(top: kNavigationBarHeight, left: 0, bottom: 0, right: 0);

            }
            self.webView.layoutIfNeeded()
            self.webView.setNeedsLayout()
        }
        if urlabsoluteString.hasPrefix("mailto") || urlabsoluteString.hasPrefix("whatsapp") {
            decisionHandler(.cancel)
        }else {
            decisionHandler(.allow)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            webView.evaluateJavaScript("document.title") { [weak self] result, error in
                if let text = result as? String {
                    self?.titlelabel.text = text
                }
            }
        }
        
    }
}
