//
//  AppDelegate.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency
import HandyJSON
import Alamofire
import Bugly
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var isGetIdfa = "0"
    var idfaUpload = "0"
    var deviceTokenUpload = "0"
    var rootTabBarVC:RootTabBarVC = RootTabBarVC()
    var application: UIApplication?
    var apiArray: [String] = []
    var isGit: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //        self.window = UIWindow(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        
        Bugly.start(withAppId: "f852fa0a53")
        
        self.setRootVC();
        
        AppLaunchUtils.shared.launchTime = DeviceInfoManager.getCurrentMillis();
        IQKeyboardManager.shared.enable = true
        
        AAILivenessSDK.initWith(.philippines)
        
        self.application = application
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if granted {
                // Authorization granted
            } else {
                print("Authorization denied")
            }
        }
        self.listeningNetAction()
        
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                // Handle the tracking authorization status if needed
            }
        }
    }
    
    func setRootVC(){
        self.window = UIWindow(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        self.window?.rootViewController = self.rootTabBarVC
        self.window?.makeKeyAndVisible();
    }
    
    
    func listeningNetAction() {
        
        let reachabilityManager = NetworkReachabilityManager()
        
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            switch status {
            case .notReachable:
                print("网络>>>>>>>>Not reachable")
            case .unknown:
                print("网络>>>>>>>>Unknown")
            case .reachable(let connectionType):
                switch connectionType {
                case .ethernetOrWiFi:
                    print("网络>>>>>>>>Connected via Ethernet or WiFi")
                case .cellular:
                    print("网络>>>>>>>>Connected via Cellular")
                }
                
                self?.testApi()
            
                // 停止网络监控
                reachabilityManager?.stopListening()
                
                
            }
        })
    }
    
    func idfaTrackingAuthorizationStatus() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
            
            if #available(iOS 14.0, *) {
                // If running on iOS 14 or later
                let authState = ATTrackingManager.trackingAuthorizationStatus
                
                if authState == .notDetermined {
                    // If tracking authorization status is not determined, request it
                    ATTrackingManager.requestTrackingAuthorization { state in
                        // Upload Google Market Info
                        self?.isGetIdfa = "1"
                        self?.checkIdfaAction()
                    }
                }else {
                    // Upload Google Market Info
                    self?.isGetIdfa = "1"
                    self?.checkIdfaAction()
                }
            }else if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                // Upload Google Market Info
                self?.isGetIdfa = "1"
                self?.checkIdfaAction()
            }
        }
    }
    
    func configPushAction (){
        
        if (self.deviceTokenUpload == "1"){
            return
        }
        
        self.application!.registerForRemoteNotifications()
        
        
        
    }
    
    func checkIdfaAction() {
        guard isGetIdfa == "1" else {
            return
        }
        guard idfaUpload != "1" else {
            return
        }
        
        NSLog("上传 idfa")
        
        let idfv = DeviceInfoManager.getIdfvAction()
        let idfa = DeviceInfoManager.getIDFA()
        
        
        let postDic: [String: String] = [
            "liked": idfv,
            "abased": AppClassUtilsHelper.getRandomeStrAction(count: 10),
            "favorite": idfa
        ]
        
        NSLog("idfa------\(postDic)")
        print("aaa  -- 上报 idfa")
        
        AppNetHelper.post_peeredFrustrationAction(params: postDic) { succ in
            print("aaa  -- 上报 idfa 成功")
            self.idfaUpload = "1"
            
            let conDic = succ.mcneil as! [String:Any]
            let detailModel = JSONDeserializer<OrderModel>.deserializeFrom(dict: conDic)
            
            AppsFlyerLib.shared().appsFlyerDevKey = detailModel?.danced ?? ""
            AppsFlyerLib.shared().appleAppID = detailModel?.prevent ?? ""
            AppsFlyerLib.shared().start()
            
        } fail: { fail in
            self.idfaUpload = "0"
        }
        
        
    }
    
    
    
}
extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let dic = userInfo["params"] as? [String: Any], let url: String = dic["acs"] as? String {
            let currentVC = currentViewController()
            if (currentVC != nil){
                AppLaunchUtils.jumpNextVCAction(rootVC: currentVC!, route: url);
            }
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("---deviceToken=\(deviceTokenString)")
        
        var postDic = [String: String]()
        postDic["gotten"] = deviceTokenString
        print("aaa  -- 上报 deviceToken")
        AppNetHelper.post_someoneMarnesAction(params: postDic) { succ in
            self.self.deviceTokenUpload = "1"
            print("\(deviceTokenString)"+"-------deviceToken上报成功")
        } fail: { fail in
            
        }
        
        
    }
    
    public func currentViewController() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return currentViewController(vc)
    }
    
    
    public func currentViewController(_ vc :UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presentVC = vc?.presentedViewController {
            return currentViewController(presentVC)
        }
        else if let tabVC = vc as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return currentViewController(selectVC)
            }
            return nil
        }
        else if let naiVC = vc as? UINavigationController {
            return currentViewController(naiVC.visibleViewController)
        }
        else {
            return vc
        }
    }
}


extension AppDelegate {
    
    func testApi() {
        let dict = ["unopposed":"1"]
        AppNetHelper.get_giturl(params: dict) { [weak self] succ in
            self?.configPushAction()
            self?.idfaTrackingAuthorizationStatus()
            // todo 有网刷新首页
            let firLaunchKeyStr = AppClassUtilsHelper.getDefaultStrWith(key: firLaunchKey)
            if (firLaunchKeyStr != "1"){
                AppClassUtilsHelper.saveUserDefault(value: "1", key: firLaunchKey)
                
                let navi = self?.rootTabBarVC.children.first as! BaseNC
                let homeVC = navi.children.first as! HomeVC
                homeVC.getAppHomeBigDataAction()
            }
        } fail: { [weak self] fail in
            self?.requestGit()
        }
    }
        
    
    
    func requestGit() {
        DispatchQueue.global(qos: .default).async {
            let originalURLString = BASE_GIT_URL
            guard let data = originalURLString.data(using: .utf8) else { return }
            let base64String = data.base64EncodedString()
            guard let decodedData = Data(base64Encoded: base64String),
                  let decodedURLString = String(data: decodedData, encoding: .utf8),
                  let url = URL(string: decodedURLString) else {
                return
            }
            do {
                let base64 = try String(contentsOf: url, encoding: .utf8)
                let decodedString = base64.replacingOccurrences(of: "\n", with: "")
                guard let finalDecodedData = Data(base64Encoded: decodedString),
                      let stringV = String(data: finalDecodedData, encoding: .utf8) else {
                    return
                }
                let stringArray = stringV.components(separatedBy: ",")
                DispatchQueue.main.async {
                    self.apiArray = stringArray
                    self.netarrayApi(goddLise, index: 0)
                }
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
    
    func netarrayApi(_ apiUrl: String, index: Int) {
        if isGit == false {
            guard index < apiArray.count else {
                return
            }
            UserDefaults.standard.set(apiArray[index], forKey: APIBAERURL)
            UserDefaults.standard.synchronize()
            let dict = ["unopposed":"1"]
            AppNetHelper.get_giturl(params: dict) { [weak self] succ in
                self?.isGit = true
                self?.configPushAction()
                self?.idfaTrackingAuthorizationStatus()
                // todo 有网刷新首页
                let firLaunchKeyStr = AppClassUtilsHelper.getDefaultStrWith(key: firLaunchKey)
                if (firLaunchKeyStr != "1"){
                    AppClassUtilsHelper.saveUserDefault(value: "1", key: firLaunchKey)
                    let navi = self?.rootTabBarVC.children.first as! BaseNC
                    let homeVC = navi.children.first as! HomeVC
                    homeVC.getAppHomeBigDataAction()
                }
            } fail: { [weak self] fail in
                self?.isGit = false
                self?.netarrayApi(goddLise, index: index + 1)
            }
        }
    }
    
}
