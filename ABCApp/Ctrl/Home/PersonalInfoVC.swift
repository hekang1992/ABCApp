//
//  PersonalInfoVC.swift
//  ABCApp
//
//  Created by Boris on 2024/2/1.
//

import UIKit
import HandyJSON

class PersonalInfoVC: BaseVC {
    
    var productId:String = "";
    var orderStr: String = "";
    var dataArr :[PersonInfoModel?] = []
    var persionStartTime:String?
//    var sourceArr:[Any]? = [];

    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, 100.px() + kNavigationBarHeight, kScreenWidth, kScreenHeight - 180.px() - kNavigationBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(WorkInformationTextCell.self, forCellReuseIdentifier: "WorkInformationTextCell")
        conTableView.register(WorkInformationSelCell.self, forCellReuseIdentifier: "WorkInformationSelCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        conTableView.tableFooterView = UIView()
        return conTableView
    }()
    
    
    lazy var confirmBtn:UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(conTableView.frame) + 10.px(), 341.px(), 50.px())
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 15.px()
        
        confirmBtn.backgroundColor = UIColor.init("#299F2D")
        confirmBtn.setTitle("Next Step", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        
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
        self.titlelabel.text = "Personal Information"
            
        getPersionalInfoMationAction()
        
        self.persionStartTime = DeviceInfoManager.getCurrentMillis()
    
        // Do any additional setup after loading the view.
    }
    

    func getPersionalInfoMationAction(){
        
        let params = ["campaign":self.productId]
        
        AppNetHelper.post_afterStandAction(params: params) { succ in
              let conDic = succ.mcneil as! [String:Any]
            let conArr:NSArray = conDic["crook"] as! NSArray
            let infoArr:[PersonInfoModel?] = JSONDeserializer<PersonInfoModel>.deserializeModelArrayFrom(array: conArr)!
            
            self.dataArr = infoArr
            self.conTableView.reloadData()
            
            print("111")
            
        } fail: { fail in
                
        }
    }
    
    @objc func confirmBtnAction (){
        
        for conModel:PersonInfoModel? in self.dataArr {
            
            if (conModel?.swelled == ""){
                AppClassUtilsHelper.makeTopHudidAction(str: (conModel?.returned!)!)
                return
            }
            
        }
        
        var postParams:[String:String] = ["sayin":AppClassUtilsHelper.getRandomeStrAction(count: 1), "campaign":self.productId]
        
        for conModel:PersonInfoModel? in self.dataArr {
            
            if (conModel?.crept == "1f"){
                postParams[conModel?.marched! ?? "nothing"] = conModel?.wrinkles
            }else{
                postParams[conModel?.marched! ?? "nothing"] = conModel?.swelled
            }
            
        }
        
        AppNetHelper.post_ticketCouldntAction(params: postParams) { succ in
            
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
                    
                }
                
                
            } fail: { fail in
                
            }
            
            // 保存成功
            print("111")
            
            let endTime:String = DeviceInfoManager.getCurrentMillis();

            let postParams:[String:String] = [
                "judicial": self.productId,   // 产品ID
                "triangle": "5",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": self.persionStartTime! , // 开始时间
                "quicker": endTime ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 个人信息 \(postParams)")

            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 个人信息 成功")

            } fail: { fail in
                print("aaa  -- 上报 个人信息 失败")

            }

            
            
        } fail: { fail in
            print("2222")
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
extension PersonalInfoVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conMode:PersonInfoModel = self.dataArr[indexPath.row]!
        
        if (conMode.crept == "1f") { //  enum
            
            let cell:WorkInformationSelCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationSelCell", for: indexPath) as! WorkInformationSelCell
            cell.selectionStyle = .none
            cell.titLabel.text = conMode.reelection
            cell.conTF.placeholder = conMode.returned
            cell.conTF.isUserInteractionEnabled = false
            
            cell.conTF.text = conMode.swelled
            
            return cell
        }else if (conMode.crept == "2f") { // text
            let cell:WorkInformationTextCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationTextCell", for: indexPath) as! WorkInformationTextCell
            cell.selectionStyle = .none
            cell.titLabel.text = conMode.reelection
            cell.conTF.placeholder = conMode.returned
            cell.conTF.isUserInteractionEnabled = true
            
            cell.workInfoTextBlockAction { textStr in
                conMode.swelled = textStr
            }
            
            cell.conTF.text = conMode.swelled

            if (conMode.middle == "1"){
                cell.conTF.keyboardType = .numberPad
            }else{
                cell.conTF.keyboardType = .default
            }
            
            return cell
        }else { // citysel
            
            let cell:WorkInformationSelCell = tableView.dequeueReusableCell(withIdentifier: "WorkInformationSelCell", for: indexPath) as! WorkInformationSelCell
            cell.selectionStyle = .none
            cell.titLabel.text = conMode.reelection
            cell.conTF.placeholder = conMode.returned
            cell.conTF.isUserInteractionEnabled = false
            cell.conTF.text = conMode.swelled
            return cell
            
        }
      
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let conModel:PersonInfoModel = self.dataArr[indexPath.row]!
        
        if (conModel.crept == "1f") { //  enum
            
            let alert = UIAlertController(title: conModel.reelection, message: "", preferredStyle: .actionSheet)

            for itemModel:PersonInfoModel? in conModel.juliette {
                let action = UIAlertAction(title: itemModel!.formed, style: .default) { [weak self] action in
                    conModel.swelled = itemModel!.formed
                    conModel.wrinkles = itemModel!.wrinkles
                    self?.conTableView.reloadData()
                }
                alert.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                // 取消操作
            }

            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }else if (conModel.crept == "3f"){
            
            
            AddressHelper.sharedInstance.getAddressAction { address in
                
                let conView = AddressPopView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
                conView.conArrSource = address.sting
                conView.conTableView1 .reloadData()
                
                conView.addressSelBlockAction { addressStr in
                    conModel.swelled = addressStr
                    self.conTableView.reloadData()
                }
                
                self.view.addSubview(conView)
                
            }
            
            
        }

    }
        
    
    
    
    
}
