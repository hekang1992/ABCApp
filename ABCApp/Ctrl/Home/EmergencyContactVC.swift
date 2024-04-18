//
//  EmergencyContactVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit
import HandyJSON
import ContactsUI

class EmergencyContactVC: BaseVC, CNContactPickerDelegate {
    
    
    var productId:String = "";
    var orderStr: String = "";
    var dataArr :[EmergencyContactModel?] = []
    var selIndex:Int = 0
    var contactStartStr:String?
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, 100.px() + kNavigationBarHeight, kScreenWidth, kScreenHeight - 180.px() - kNavigationBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(EmergencyContactCell.self, forCellReuseIdentifier: "EmergencyContactCell")
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
        
        confirmBtn.addTarget(self, action: #selector(confirmACtion), for: .touchUpInside)
        
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
        self.titlelabel.text = "Emergency Contact"
            
        self.getEmergencyListAction()

        self.contactStartStr = DeviceInfoManager.getCurrentMillis()
        
        // Do any additional setup after loading the view.
    }
    

    func getEmergencyListAction (){
        
        let postParams = ["campaign":self.productId, "weighed":AppClassUtilsHelper.getRandomeStrAction(count: 10)]
        
        AppNetHelper.post_drivenGreatAction(params: postParams) { succ in
            
            
            
            let conDic = succ.mcneil as! [String:Any]
            
            let desiresDic:[String:Any] = conDic["desires"] as! [String:Any]

            
            let conArr:NSArray = desiresDic["sting"] as! NSArray
            let infoArr:[EmergencyContactModel?] = JSONDeserializer<EmergencyContactModel>.deserializeModelArrayFrom(array: conArr)!
            
            for conModle:EmergencyContactModel? in infoArr {
                conModle?.selformed = conModle?.relation_name
            }
            
            self.dataArr = infoArr
            self.conTableView.reloadData()
            
            
            print("111")
            
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
        // Get the new view controller using                                segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EmergencyContactVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EmergencyContactCell = tableView.dequeueReusableCell(withIdentifier: "EmergencyContactCell", for: indexPath) as! EmergencyContactCell
        let conModel:EmergencyContactModel = self.dataArr[indexPath.row]!
        cell.titLabel.text = conModel.array
        cell.selectionStyle = .none
        cell.topTypeTF.text = conModel.selformed
        
        cell.mobileTF.text = conModel.beckoned
        cell.chooseContactTF.text = conModel.formed
        
        cell.selTopblockAction {
            
            
            let alert = UIAlertController(title: "Relationship", message: "", preferredStyle: .actionSheet)

            for itemModel:EmergencyContactModel in conModel.consciences {
                let action = UIAlertAction(title: itemModel.formed, style: .default) { [weak self] action in
                    conModel.selformed = itemModel.formed
                    conModel.wants = itemModel.wrinkles
                    self?.conTableView.reloadData()
                }
                alert.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                // 取消操作
            }

            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            print("111")
        }
        cell.selBottomblockAction {
            print("222")
            
            self.selIndex = indexPath.row;
            
            let picker = CNContactPickerViewController()
            picker.delegate = self
            self.present(picker, animated: true)
            
            
        }
        
        return cell
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        
        let name = contact.givenName+contact.familyName
        var phone = "";
        if (contact.phoneNumbers.count > 0){
            let phoneLabeledValue:CNLabeledValue = contact.phoneNumbers.first!
            let phoneValue:CNPhoneNumber = phoneLabeledValue.value
            phone = phoneValue.stringValue
        }
        
        if (phone == ""){
            AppClassUtilsHelper.makeTopHudidAction(str: "Invalid contact person.")
            return
        }
  
        let conModel = self.dataArr[self.selIndex];
        conModel?.formed = name;
        conModel?.beckoned = phone;
        self.conTableView.reloadData()
        
    }
    
    @objc func confirmACtion (){
        
        var postParams:[String:String] = ["campaign":self.productId]
        var postArr = [[String:String]]()
        for conModel:EmergencyContactModel? in self.dataArr {
            
            if (conModel?.beckoned == "" || conModel?.formed == "" || conModel?.wants == "") {
                AppClassUtilsHelper.makeTopHudidAction(str: "Please fill out the complete form")
                return
            }
            let postDict: [String: String] = ["beckoned":conModel?.beckoned ?? "",
                                              "formed":conModel?.formed ?? "",
                                              "wants":conModel?.wants ?? "",
                                              "impression":conModel?.impression ?? ""
                                             ]
            
            postArr.append(postDict)
                        
        }
        let postStr = toJsonStr(withArray: postArr)

        postParams["mcneil"] = postStr
        
        
        AppNetHelper.post_whoseStillAction(params: postParams) { succ in
            
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
            
            let endTime:String = DeviceInfoManager.getCurrentMillis();

            let postParams:[String:String] = [
                "judicial": self.productId,   // 产品ID
                "triangle": "7",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": self.contactStartStr! , // 开始时间
                "quicker": endTime ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 联系人信息 \(postParams)")

            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 联系人信息 成功")

            } fail: { fail in
                print("aaa  -- 上报 联系人信息 失败")

            }
            
            
        } fail: { fail in
            
        }

        
        
    }
    
    func toJsonStr(withArray arr: Any) -> String {
        guard let array = arr as? [Any] else {
            if let stringArray = arr as? String {
                return stringArray
            }
            return ""
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            var jsonStr = String(data: jsonData, encoding: .utf8) ?? ""
            jsonStr = jsonStr.trimmingCharacters(in: .whitespacesAndNewlines)
            jsonStr = jsonStr.replacingOccurrences(of: " ", with: "")
            jsonStr = jsonStr.replacingOccurrences(of: "\n", with: "")
            return jsonStr
        } catch {
            return ""
        }
    }
    
}
