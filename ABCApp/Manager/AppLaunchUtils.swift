//
//  AppLaunchUtils.swift
//  ABCApp
//
//  Created by Boris on 2024/1/24.
//

import UIKit
import HandyJSON

class AppLaunchUtils: NSObject {

    static let shared: AppLaunchUtils = {
        let instance = AppLaunchUtils()
        return instance
    }()
    
    public var launchTime : String = ""
    
}

extension AppLaunchUtils {
    
    class public func jumpNextVCAction (rootVC:UIViewController, route:String) {
        

        
        if (route.contains("ace://yy.ee/") == true){
            
            let routeStr = route.replacingOccurrences(of: "ace://yy.ee/", with: "")
            
            let routeArr = routeStr.components(separatedBy: "?")
            let routeType = routeArr.first
            
            if (routeType == "believeCorner"){ // 首页
                
            
                let tab:RootTabBarVC = rootVC.navigationController?.parent as! RootTabBarVC
                rootVC.navigationController?.popToRootViewController(animated: false)
                tab.selectedIndex = 0;
                let homeNC:BaseNC = tab.children.first as! BaseNC;
                let homeVC:HomeVC = homeNC.children.first as! HomeVC;
                
            }else if (routeType == "inevitableThought"){ // 登录页
                let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                loginView.selblockSuccessAction {
                    print("")
                    let navi = appdelegate.rootTabBarVC.children.first as! BaseNC
                    let homeVC = navi.children.first as! HomeVC
                    homeVC.getAppHomeBigDataAction()
                    homeVC.startLocationAction()
                }

               let vc = getCurrentUIVC() as! UIViewController
               vc.view.addSubview(loginView)
            }else if (routeType == "scanningFinally"){ // 订单列表页
                
                let paramsStr = routeArr.last
                let paramsArr = paramsStr?.components(separatedBy: "=")
                let tabIndex = paramsArr?.last
       
                let vc = OrderListVC()
                rootVC.navigationController?.pushViewController(vc, animated: true)
                
            }else if (routeType == "noddedBreath"){   // 产品详情
                
                let paramsStr = routeArr.last
                let paramsArr = paramsStr?.components(separatedBy: "=")
                let productId = paramsArr?.last
                
                
                
                let vc = AuthenticationVC()
                vc.productId = productId!
                rootVC.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if (routeType == "stressingLanded"){ // 客服首页
                print("")
            }else if (routeType == "unitIsOver"){ // 客服首页
                print("")
                
                let recommendListVC = RecommendListVC()
                rootVC.navigationController?.pushViewController(recommendListVC, animated: true)
                
            }
            
            
        }else{
            
            let paramsStr = AppAFNetManager.getPublicParamsAction()
            let webVC = AppWebViewVC()
            if (route.contains("?") == true){
                webVC.urlStr = route + "&" + paramsStr
            }else{
                webVC.urlStr = route + "?" + paramsStr
            }
            rootVC.navigationController?.pushViewController(webVC, animated: true)

            
        }
        
    }
    
    class public func pushVerifyVCAction(rootVC:UIViewController, route:String, productId:String, order:String){
        
        if (route == "33"){
            
            let paramsDic = ["campaign":productId,
                             "possibly":AppClassUtilsHelper.getRandomeStrAction(count: 12)]
            
            
            AppNetHelper.get_thickContainment(params: paramsDic) { succ in
                
                
                let conDic = succ.mcneil as! [String:Any]
                let idInfoModle = JSONDeserializer<InfomationModel>.deserializeFrom(dict: conDic)
                
                if (idInfoModle?.names?.pause == "1") {
                    let vc =  IDVerificationVC()
                    vc.productId = productId
                    vc.orderStr = order
                    rootVC.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = IDCardTypeVC()
                    vc.productId = productId;

                    vc.orderStr = order
                    rootVC.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            } fail: { fail in
                
            }

            
        }else if (route == "44"){
            
            let vc =  PersonalInfoVC()
            vc.productId = productId
            vc.orderStr = order
            rootVC.navigationController?.pushViewController(vc, animated: true)
            
        }else if (route == "55"){
            
            let vc =  WorkInformationVC()
            vc.productId = productId
            vc.orderStr = order
            rootVC.navigationController?.pushViewController(vc, animated: true)
            
        }else if (route == "66"){
            
            let vc =  EmergencyContactVC()
            vc.productId = productId
            vc.orderStr = order
            rootVC.navigationController?.pushViewController(vc, animated: true)
            
        }else if (route == "77"){
            
            let vc =  E_walletBankCardVC()
            vc.productId = productId
            vc.orderStr = order
            rootVC.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    
    
}

