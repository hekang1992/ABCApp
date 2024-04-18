//
//  E-walletBankCardVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit
import HandyJSON

class E_walletBankCardVC: BaseVC {
    
    var productId:String = "";
    var orderStr: String = "";
    var cardModel:BankCardModel?
    var selIndex:Int = 0
    
    var dataArr :[BankCardModel] = []
    var cardStartStr : String?
    
    lazy var conBottomView: UIView = {
        
        let conBottomView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 100.px()))
        conBottomView.addSubview(walletBtn)
        conBottomView.addSubview(cardBtn)
        return conBottomView
        
    }()
    
    lazy var walletBtn:UIButton = {
        let walletBtn = UIButton(type: .custom)
        walletBtn.frame = CGRectMake(17.px(), 30.px(), 156.px(), 50.px())
        walletBtn.layer.masksToBounds = true
        walletBtn.layer.cornerRadius = 15.px()
        
        walletBtn.backgroundColor = UIColor.white
//        walletBtn.setTitle("E-wallet", for: .normal)
        walletBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        walletBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        walletBtn.addTarget(self, action: #selector(walletBtnAction), for: .touchUpInside)
        walletBtn.isHidden = true
        return walletBtn
    }()
    
    lazy var cardBtn:UIButton = {
        let cardBtn = UIButton(type: .custom)
        cardBtn.frame = CGRectMake(203.px(), 30.px(), 156.px(), 50.px())
        cardBtn.layer.masksToBounds = true
        cardBtn.layer.cornerRadius = 15.px()
        
        cardBtn.backgroundColor = UIColor.white
//        cardBtn.setTitle("Bank Card", for: .normal)
        cardBtn.setTitleColor(UIColor.init("#DDAE02"), for: .normal)
        cardBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        cardBtn.addTarget(self, action: #selector(cardBtnAction), for: .touchUpInside)
        cardBtn.isHidden = true
        return cardBtn
    }()
    

    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, 100.px() + kNavigationBarHeight, kScreenWidth, kScreenHeight - 180.px() - kNavigationBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(WorkInformationTextCell.self, forCellReuseIdentifier: "WorkInformationTextCell")
        conTableView.register(WorkInformationSelCell.self, forCellReuseIdentifier: "WorkInformationSelCell")
        conTableView.register(WorkInformationWalletCell.self, forCellReuseIdentifier: "WorkInformationWalletCell")
        conTableView.register(WorkInformationSelHeightCell.self, forCellReuseIdentifier: "WorkInformationSelHeightCell")
        
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        conTableView.tableHeaderView = conBottomView
        return conTableView
    }()
    
    
    lazy var confirmBtn:UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(conTableView.frame) + 10.px(), 341.px(), 50.px())
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 15.px()
        
        confirmBtn.backgroundColor = UIColor.init("#299F2D")
        confirmBtn.setTitle("Complete", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        
        confirmBtn.addTarget(self, action: #selector(confirmBtmAction), for: .touchUpInside)
        
        return confirmBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + 136.px()))
        bgView.backgroundColor = UIColor.init("#FFF2E0")
        self.view.addSubview(bgView)
        
        let topImgView = UIImageView(image: UIImage(named: "bg_idcadtype"))
        topImgView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 136.px())
        self.view.addSubview(topImgView)
        
        
        let backView = UIImageView(image: UIImage(named: "bg_yanzheng"))
        backView.frame = CGRectMake(0, CGRectGetMaxY(topImgView.frame), kScreenWidth, kScreenHeight - kNavigationBarHeight - 136.px())
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backView.layer.addSublayer(bgLayer1)
        
        self.view.addSubview(backView)
        
        self.view.addSubview(self.conTableView)
        self.view.addSubview(confirmBtn)
        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "E-wallet & Bank Card"
            
        self.getCardAction()
        
        self.cardStartStr = DeviceInfoManager.getCurrentMillis()
        
        // Do any additional setup after loading the view.
    }
    
    func getCardAction (){
        
        let paramsDic:[String:String] = ["dulled":"0", "sunrise": AppClassUtilsHelper.getRandomeStrAction(count: 10)]
        
        AppNetHelper.get_sinisterAction(params: paramsDic) { succ in
            
            
            let conDic = succ.mcneil as! [String:Any]
            let cardModel = JSONDeserializer<BankCardModel>.deserializeFrom(dict: conDic)
            self.cardModel = cardModel!
            let walletModel:BankCardModel? =  self.cardModel?.crook.first
            
            for conItem:BankCardModel? in walletModel!.crook {
                
                if (conItem?.crept == "1f"){
                    for subItem:BankCardModel in conItem!.juliette {
                        if (subItem.wrinkles ==  conItem?.wrinkles){
                            conItem?.selunspoiled = subItem.unspoiled
                        }
                    }
                }
            }
            
            let bankModel:BankCardModel? =  self.cardModel?.crook.last
            
            
            
            self.walletBtn.setTitle(walletModel?.reelection, for: .normal)
            self.cardBtn.setTitle(bankModel?.reelection, for: .normal)
            self.dataArr = walletModel!.crook
            self.selIndex = 0;
            self.conTableView.reloadData()
            
            self.walletBtn.isHidden = false
            self.cardBtn.isHidden = false
            
            print("111")
        } fail: { fail in
            print("111")
        }

        
    }
    
    @objc func walletBtnAction(){
        self.selIndex = 0
        self.walletBtn.backgroundColor = UIColor.white
        self.walletBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        
        self.cardBtn.backgroundColor = UIColor.white
        self.cardBtn.setTitleColor(UIColor.init("#DDAE02"), for: .normal)
     
        let walletModel:BankCardModel? =  self.cardModel?.crook.first
        self.dataArr = walletModel!.crook
        self.conTableView.reloadData()
        
    }
    
    @objc func cardBtnAction(){
        self.selIndex = 1
        self.walletBtn.backgroundColor = UIColor.white
        self.walletBtn.setTitleColor(UIColor.init("#DDAE02"), for: .normal)
        
        self.cardBtn.backgroundColor = UIColor.white
        self.cardBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        
        let bankModel:BankCardModel? =  self.cardModel?.crook.last
        self.dataArr = bankModel!.crook
        self.conTableView.reloadData()
    }
    
    @objc func confirmBtmAction (){
        
        let conModel:BankCardModel
        if (self.selIndex == 0){
            let walletModel:BankCardModel? =  self.cardModel?.crook.first
            conModel = walletModel!
        }else{
            let bankModel:BankCardModel? =  self.cardModel?.crook.last
            conModel = bankModel!
        }
        
        for conItem:BankCardModel in conModel.crook {
            
            if (conItem.swelled == ""){
                AppClassUtilsHelper.makeTopHudidAction(str: "Please fill out the complete form")
                return
            }
        }
        
        var postParams:[String:String] = ["promoted":self.selIndex == 0 ? "1" : "2",
                                          "campaign":self.productId,
                                          "deceased":AppClassUtilsHelper.getRandomeStrAction(count: 10)
        ]
        
        
        for conItem:BankCardModel in conModel.crook {

            if (conItem.crept == "1f"){
                postParams[conItem.marched! ?? "nothing"] = conItem.wrinkles
            }else{
                postParams[conItem.marched! ?? "nothing"] = conItem.swelled
            }
            
        }
        
        do {
            // 创建一个Encoder来编码字典为Data类型
            let encoder = JSONEncoder()
            
            // 将字典编码成Data
            let data = try encoder.encode(postParams)
            
            // 将Data转换为UTF-8编码的字符串
            if let jsonString = String(data: data, encoding: .utf8) {
                print("转换后的JSON字符串:\n\(jsonString)")
                
                // 如果需要输出原始的JSON数据，则可以直接打印data变量
                //print("\n原始的JSON数据:\n\(data)")
            } else {
                print("无法将Data转换为UTF-8编码的字符串")
            }
        } catch {
            print("发生错误：\(error)")
        }
                
        AppNetHelper.post_sacrificeAction(params: postParams) { succ in

            
            
            
            let endTime:String = DeviceInfoManager.getCurrentMillis();

            let postParams:[String:String] = [
                "judicial": self.productId,   // 产品ID
                "triangle": "8",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": self.cardStartStr! , // 开始时间
                "quicker": endTime ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 银行卡信息 \(postParams)")

            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 银行卡信息 成功")

            } fail: { fail in
                print("aaa  -- 上报 银行卡信息 失败")

            }
            
            
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
                    
                    // 跟进订单号
                    print("333")
                    let paramsSource:[String:String] = [
                        "smelled":detailModel?.concern?.toying ?? "",
                        "violation":AppClassUtilsHelper.getRandomeStrAction(count: 3),
                        "clouding":AppClassUtilsHelper.getRandomeStrAction(count: 6),
                        "brutal":AppClassUtilsHelper.getRandomeStrAction(count: 6),
                        "assault":AppClassUtilsHelper.getRandomeStrAction(count: 6)
                    ]
                    
                    let startTime:String = DeviceInfoManager.getCurrentMillis();

                    AppNetHelper.post_angleCrowdsAction(params: paramsSource) { succ in
                        print("111")
                        let conDic = succ.mcneil as! [String:Any]
                        let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                        AppLaunchUtils.jumpNextVCAction(rootVC: self, route: detailModel?.giving ?? "")                        
                        
                        let endTime1:String = DeviceInfoManager.getCurrentMillis();
                        
                        
                        
                        let endTime:String = DeviceInfoManager.getCurrentMillis();

                        let postParams:[String:String] = [
                            "judicial": self.productId,   // 产品ID
                            "triangle": "9",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                            "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                            "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                            "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                            "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                            "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                            "practiced": startTime , // 开始时间
                            "quicker": endTime ,   // 结束时间
                            "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
                        ]
                        print("aaa  -- 上报 开始申贷信息 \(postParams)")

                        AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                            print("aaa  -- 上报 开始申贷信息 成功")

                        } fail: { fail in
                            print("aaa  -- 上报 开始申贷信息 失败")

                        }
                        
                        
                    } fail: { fail in
                        print("222")
                    }


                }
              
                
                
            } fail: { fail in
                
            }

        } fail: { fail in
            print("222")
        }

    
        
        
        
    }
        
    @objc override func backClick() {
        
        let alert = UIAlertController(title: "Are you sure you want to leave?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel) { action in
            for vc in self.navigationController!.children {
                if let borrowingVC = vc as? AuthenticationVC {
                    self.navigationController?.popToViewController(borrowingVC, animated: true)
                    return
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        let doneAction = UIAlertAction(title: "Give Up", style: .destructive) { action in
            // Handle continue action if needed
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
        
        
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
extension E_walletBankCardVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let conModel = self.dataArr[indexPath.row]
        
        if (conModel.crept == "1f"){
            return 131.px()
        }
        
        return 111.px()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conModel = self.dataArr[indexPath.row]
        
        if (conModel.crept == "1f"){
            if (self.selIndex == 0){
                let cell:WorkInformationWalletCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationWalletCell", for: indexPath) as! WorkInformationWalletCell
                cell.selectionStyle = .none
                cell.titLabel.text = conModel.reelection
                cell.conTF.placeholder = conModel.returned
                cell.conTF.text = conModel.swelled
                cell.leftConImgView.kf.setImage(with: URL(string: conModel.selunspoiled ?? ""))
                
        
                return cell
            }else{
                let cell:WorkInformationSelHeightCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationSelHeightCell", for: indexPath) as! WorkInformationSelHeightCell
                cell.selectionStyle = .none
                cell.titLabel.text = conModel.reelection
                cell.conTF.placeholder = conModel.returned
                cell.conTF.text = conModel.swelled
                return cell
            }
            
        }
        
        let cell:WorkInformationTextCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationTextCell", for: indexPath) as! WorkInformationTextCell
        cell.titLabel.text = conModel.reelection
        cell.conTF.placeholder = conModel.returned
        
        cell.conTF.text = conModel.swelled                                                                                                 
        if (conModel.middle == "1"){
            cell.conTF.keyboardType = .numberPad
        }else{
            cell.conTF.keyboardType = .default
        }
        cell.selectionStyle = .none
        cell.workInfoTextBlockAction { textStr in
            conModel.swelled = textStr
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conModel = self.dataArr[indexPath.row]
        
        if (conModel.crept == "1f"){
            
            let alert = UIAlertController(title: conModel.reelection, message: "", preferredStyle: .actionSheet)

            for itemModel:BankCardModel? in conModel.juliette {
                let action = UIAlertAction(title: itemModel!.formed, style: .default) { [weak self] action in
                    conModel.swelled = itemModel!.formed
                    conModel.wrinkles = itemModel!.wrinkles
                    conModel.selunspoiled = itemModel?.unspoiled
                      self?.conTableView.reloadData()
                }
                alert.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                // 取消操作
            }

            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}

