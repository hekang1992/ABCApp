//
//  OrderListVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit
import HandyJSON
import Kingfisher

class OrderListVC: BaseVC {
    
    
    var orderType:String?
    var dataArr :[OrderModel?] = []
    
    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(OrderCell1.self, forCellReuseIdentifier: "OrderCell1")
        conTableView.register(OrderCell2.self, forCellReuseIdentifier: "OrderCell2")
        conTableView.register(OrderCell3.self, forCellReuseIdentifier: "OrderCell3")
        
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        conTableView.tableFooterView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 20.px()))
        conTableView.tableHeaderView = UIView()
        
        conTableView.addSubview(self.noView)
        
        return conTableView
    }()
    
    lazy var noView:NullView = {
        let noView = NullView.init(frame: CGRectMake(0, 100.px(), kScreenWidth, 320.px()))
        noView.isHidden = true
        return noView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let postParams = ["cringe":self.orderType ?? ""]
        
        AppNetHelper.post_turnedToxinsAction(params: postParams) { succ in
            print("111")
            let conDic = succ.mcneil as! [String:Any]
            
            guard  let conArr:NSArray = conDic["sting"] as? NSArray else {
                return
            }
            
            let infoArr:[OrderModel?] = JSONDeserializer<OrderModel>.deserializeModelArrayFrom(array: conArr)!
            
            //            let model = infoArr.first
            //            model??.myTree = "Repay"
            //            model??.flowed = "1111"
            
            
            self.dataArr = infoArr
            self.conTableView.reloadData()
            
        } fail: { fail in
            print("222")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor.init("#FFF4CF")
        self.view.addSubview(self.conTableView)
        
        self.addBackBtnAction()
        self.addTitleLabelAction()
        
        // Do any additional setup after loading the view.
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
extension OrderListVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.dataArr.count == 0){
            self.noView.isHidden = false
        }else{
            self.noView.isHidden = true
        }
        
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 先获取 按钮宽度
        let conModel = self.dataArr[indexPath.row]
        var cellHeight = 124.px();
        
        if (conModel?.flowed?.count == 0 && conModel?.myTree?.count == 0){
            return 114.px()
        }
        
        var btnWidth = 0.px()
        var textWidth =  kScreenWidth - 64.px() - 30.px()
        if (conModel?.myTree?.count ?? 0 > 0){
            // 获取按钮宽度
            btnWidth = AppHelper.getStrWidth(str: conModel?.myTree ?? "", height: 20.px(), font:  UIFont(name: kOSRegular, size: 16.px())!)
            btnWidth += 30.px()
            
            textWidth = kScreenWidth - 64.px() - 15.px() - btnWidth - 9.px()
            
        }
        var textHeight = 46.px()
        var realTextH = AppHelper.getStrHeight(str: conModel?.flowed ?? "", width: textWidth, font: UIFont(name: kOSRegular, size: 16.px())!) + 20.px()
        textHeight = textHeight > realTextH ? textHeight : realTextH
        
        return cellHeight + textHeight
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        if (indexPath.row == 1){
        //
        //            let cell:OrderCell2 = tableView.dequeueReusableCell(withIdentifier: "OrderCell2", for: indexPath) as! OrderCell2
        //            cell.selectionStyle = .none
        //            return cell
        //
        //        }
        //
        //        if (indexPath.row == 2){
        //
        //            let cell:OrderCell3 = tableView.dequeueReusableCell(withIdentifier: "OrderCell3", for: indexPath) as! OrderCell3
        //            cell.selectionStyle = .none
        //            return cell
        //
        //        }
        let conModel = self.dataArr[indexPath.row]
        
        let cell:OrderCell1 = tableView.dequeueReusableCell(withIdentifier: "OrderCell1", for: indexPath) as! OrderCell1
        cell.titLabel.text = conModel?.surging
        cell.priceLabel.text = conModel?.winds
        cell.conImgView.kf.setImage(with: URL(string: conModel?.fighting ?? ""))
        
        cell.selectionStyle = .none
        cell.conBottomView.backgroundColor = UIColor.init("#299F2D") // 绿
        
        if (conModel?.flowed?.count == 0 && conModel?.myTree?.count == 0){
            cell.conBottomView.isHidden = true
        }else{
            cell.conBottomView.isHidden = false
            cell.setCellConViewAction(conModel: conModel!)
        }
        
        
        if (self.orderType == "8"){
            cell.conBottomView.backgroundColor = UIColor.init("#FF5D00") // 黄
        }
        if (self.orderType == "6"){
            
            if(conModel?.sheets == "180"){
                cell.conBottomView.backgroundColor = UIColor.init("#FF5D00") // 黄
            }
            
        }
        cell.selblockAction {
            
            
//            AppLaunchUtils.jumpNextVCAction(rootVC: self, route: conModel?.yourUinit ?? "")
            
            let rout = conModel?.yourUinit ?? ""
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
            
            
            print("111")
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let conModel = self.dataArr[indexPath.row]
        let rout = conModel?.fickle ?? ""
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
        
        
        //        AppLaunchUtils.jumpNextVCAction(rootVC: self, route: )
    }
    
}
