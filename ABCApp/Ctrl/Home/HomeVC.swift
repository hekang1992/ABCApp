//
//  HomeVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/23.
//

import UIKit
import SystemServices
import HandyJSON
import MJRefresh
import TYAlertController

class HomeVC: BaseMainVC {
    
    var appHomeModel:HomeModel? = nil
    
    lazy var homeRoot1View: Root1View = {
        
        let homeRoot1View = Root1View.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCustomTabBarHeight))
        homeRoot1View.backgroundColor = UIColor.white
        
        homeRoot1View.selblockAction{ [weak self] in
        
            guard let sessionStr = AppClassUtilsHelper.getUserDefault(key: sessionUser), let conSessionStr:String = sessionStr as? String, conSessionStr.count > 0 else {
                let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
                loginView.selblockSuccessAction(block: { [weak self] in
                    self?.getAppHomeBigDataAction()
                    self?.startLocationAction()
                    // 登录成功开始定位
                })
                self?.view.addSubview(loginView)
                return
            }
            
            if (self!.appHomeModel == nil){
                return
            }
            
            self?.getProductDetailAction(juices: self?.appHomeModel?.crowds?.honorific?.juices ?? "", source: "1")
           
            print("111")
        }
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            self.getAppHomeBigDataAction()
        } as! MJRefreshComponentAction)

        // Set title
        header.setTitle("Pull down to refresh", for: .idle)
        header.setTitle("Release to refresh", for: .pulling)
        header.setTitle("Loading ...", for: .refreshing)
        header.ignoredScrollViewContentInsetTop = kIsNotchScreen ? 40.px() : 10.px();
        // Hide the time
        header.lastUpdatedTimeLabel?.isHidden = true

        
        header.stateLabel?.setValue( UIFont(name: kOSBold, size: 14.px()), forKey: "font")

        // Set textColor
//        header.stateLabel.textColor = UIColor(hexString: "#666666")
        homeRoot1View.conScrollowView.mj_header = header
        
        return homeRoot1View
    }()
    
    lazy var homeRoot2View: Root2View = {
        
        let homeRoot2View = Root2View.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCustomTabBarHeight))
        homeRoot2View.backgroundColor = UIColor.init(hexString: "#FFF4CF")
        homeRoot2View.isHidden = true
        homeRoot2View.selBannerblockAction{ route in            
            AppLaunchUtils.jumpNextVCAction(rootVC: self, route: route);
            
        }
        
        homeRoot2View.selProductblockAction{ productId in
            self.getProductDetailAction(juices: productId, source: "2")
        }
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            self.getAppHomeBigDataAction()
        } as! MJRefreshComponentAction)
        header.ignoredScrollViewContentInsetTop = kIsNotchScreen ? 40.px() : 10.px();
        // Set title
        header.setTitle("Pull down to refresh", for: .idle)
        header.setTitle("Release to refresh", for: .pulling)
        header.setTitle("Loading ...", for: .refreshing)

        // Hide the time
        header.lastUpdatedTimeLabel?.isHidden = true

        header.stateLabel?.setValue( UIFont(name: kOSBold, size: 14.px()), forKey: "font")

        // Set textColor
//        header.stateLabel.textColor = UIColor(hexString: "#666666")
        homeRoot2View.conTableView.mj_header = header
        
        return homeRoot2View
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAppHomeBigDataAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.homeRoot2View)

        self.view.addSubview(self.homeRoot1View)
        
        self.left1View.iconImg.image = UIImage.init(named: "icon_home_selected")
        self.left1View.setSelAction()
        
        
        AddressHelper.sharedInstance.getAddressAction { address in
            
        }

//        self.getAppHomeBigDataAction()
        // 开始定位
        self.startLocationAction()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    public func getAppHomeBigDataAction (){
        
//        AppHelper.showLoading()
        
        AppNetHelper.get_artifactsCondensedAction { succ in
            
//            AppHelper.hid()
            
            self.homeRoot1View.conScrollowView.mj_header?.endRefreshing();
            self.homeRoot2View.conTableView.mj_header?.endRefreshing();
            
            let conDic = succ.mcneil as! [String:Any]
            let homeModel = JSONDeserializer<HomeModel>.deserializeFrom(dict: conDic)
            self.appHomeModel = homeModel
            let mongyeF = self.appHomeModel?.mongye ?? ""
            UserDefaults.standard.setValue(mongyeF, forKey: "mongyeF")
            UserDefaults.standard.synchronize()
            if(homeModel?.sting?.wrinkles == "5a"){
                self.homeRoot1View.isHidden = true
                self.homeRoot2View.isHidden = false

                let homeSubModel = JSONDeserializer<HomeSubModel>.deserializeFrom(dict: conDic)
                print("111");
                
                self.homeRoot2View.dataSource = homeSubModel?.sting?.honorific
                self.homeRoot2View.conTableView.reloadData()
                self.homeRoot2View.conModel = homeSubModel
                self.homeRoot2View.setConModelAction()
            }
            
            if(homeModel?.crowds?.wrinkles == "2a"){
                self.homeRoot1View.isHidden = false
                self.homeRoot2View.isHidden = true
                self.homeRoot1View.imgPso.isHidden = false
                // 1
                self.homeRoot1View.topConImgViewTitle.text = homeModel?.crowds?.honorific?.muttering
                
                self.homeRoot1View.bottom1Title.text = homeModel?.crowds?.honorific?.holiday
                self.homeRoot1View.bottom1Desc.text = homeModel?.crowds?.honorific?.pilgrimage
                
                self.homeRoot1View.bottom2Title.text = homeModel?.crowds?.honorific?.throughout
                self.homeRoot1View.bottom2Desc.text = homeModel?.crowds?.honorific?.asking
                
                self.homeRoot1View.topConImgViewDesc.text = homeModel?.crowds?.honorific?.shooed
                
                let width = AppHelper.getStrWidth(str: homeModel?.crowds?.honorific?.shooed ?? "", height: 51.px(), font: UIFont(name: kOSBold, size: 37.px())!)
                
                self.homeRoot1View.imgPso.frame = CGRectMake(CGRectGetMidX(self.homeRoot1View.topConImgViewDesc.frame) - width  / 2 - 40.px(), CGRectGetMidY(self.homeRoot1View.topConImgViewDesc.frame) - 14.px(), 32.px(), 29.px())
                
                
                self.homeRoot1View.applyLabel.text = homeModel?.crowds?.honorific?.testy
                                                       
            }
            
            print(succ.toJSON())
            
        } fail: { fail in
//            AppHelper.hid()
        }

        
    }
    
    // apply
    func getProductDetailAction (juices:String, source:String){
        let postModel:[String:String] = [
            "campaign":juices,
            "bullets": AppClassUtilsHelper.getRandomeStrAction(count: 10),
            "chasing": AppClassUtilsHelper.getRandomeStrAction(count: 10),
        ]
        print(postModel)
        
        AppNetHelper.post_destructionAction(params: postModel) { succ in
            
            let conDic = succ.mcneil as! [String:Any]
            let productModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
//            productModel?.giving = "ace://yy.ee/noddedBreath?campaign=1"
            if (productModel?.giving?.count == 0){
                let vc = AuthenticationVC()
                vc.productId = juices
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                if (source == "2"){
                    if (productModel?.giving?.contains("ace://yy.ee/") == true){
                        let paramsDic = [
                            "campaign":juices,
                            "wavered":AppClassUtilsHelper.getRandomeStrAction(count: 3),
                            "fortieth":AppClassUtilsHelper.getRandomeStrAction(count: 6)
                            
                        ]
                        
//                        AppHelper.showLoading()

                        AppNetHelper.post_weveAreAction(params: paramsDic) { succ in
                            
                            let conDic = succ.mcneil as! [String:Any]
                            let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                            
                            if (detailModel?.squeaked != "200"){
                                AppLaunchUtils.jumpNextVCAction(rootVC: self, route: detailModel?.giving ?? "")
                                return
                            }
                            
                            if (detailModel?.honestly?.decide == "33" || detailModel?.honestly?.decide == "44" || detailModel?.honestly?.decide == "55" || detailModel?.honestly?.decide == "66" || detailModel?.honestly?.decide == "77"){
                                
                                AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: juices, order: detailModel?.concern?.toying ?? "")
                                
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
//                                    AppHelper.hid()
                                } fail: { fail in
//                                    AppHelper.hid()
                                    print("222")
                                }
                            }
                            
                   
                        } fail: { fail in
//                            AppHelper.hid()
                        }
                        
                    }else{
                        AppLaunchUtils.jumpNextVCAction(rootVC: self, route: productModel?.giving! ?? "");
                        
                    }
                    
                }else{
                    if self.appHomeModel?.mongye == "0" {
                        AppLaunchUtils.jumpNextVCAction(rootVC: self, route: productModel?.giving! ?? "");
                    }else{
                        let str:String = productModel?.giving ?? ""
                        if (!str.contains("https://")) {
                            let mongyeF = self.appHomeModel?.mongye ?? ""
                            UserDefaults.standard.setValue(mongyeF, forKey: "mongyeF")
                            UserDefaults.standard.synchronize()
                            let vc = AlertDescViewController()
                            vc.productId = juices
                            vc.type = self.appHomeModel?.mongye ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            AppLaunchUtils.jumpNextVCAction(rootVC: self, route: productModel?.giving! ?? "");
                        }
                    }
                }
            }
        } fail: { fail in
            
        }
    }
    
    func startLocationAction (){
        
        guard let sessionStr = AppClassUtilsHelper.getUserDefault(key: sessionUser), let conSessionStr:String = sessionStr as? String, conSessionStr.count > 0 else {
            return
        }
             
        LocationManager.sharedInstance.startRequestLocation()
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
