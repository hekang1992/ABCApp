//
//  IDCardTypeVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit
import HandyJSON

typealias IDCardTypeVCBlockClass = (_ typeStr:String) -> ()

    

class IDCardTypeVC: BaseVC {

    var productId:String = "";
    var orderStr: String = "";

    var sourceArr:[HomeSubModel]? = [];

    var selTypeBlock: IDCardTypeVCBlockClass?
    
    var startTime:String = DeviceInfoManager.getCurrentMillis()
    

    lazy var warmingView:UIView = {
        
        let warmingView = UIView(frame: CGRectMake(kScreenWidth - 283.px(), kNavigationBarHeight + 26.px(), 283.px(), 59.px()))
        
        warmingView.backgroundColor = UIColor.init("#299F2D")
        warmingView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        warmingView.layer.cornerRadius = 15.px()
        
        let backView = UIImageView(image: UIImage(named: "icon_tostIdType"))
        backView.frame = CGRectMake(016.px(), 21.px(), 5.px(), 19.px())
        warmingView.addSubview(backView)
        
        let warmingLabel = UILabel(frame: CGRectMake(37.px(), 0.px(), 226.px(), 59.px()))
        warmingLabel.text = "Please be sure to choose an ID type that matches your identification card!"
        warmingLabel.font =  UIFont(name: kOSRegular, size: 15.px())
        warmingLabel.textColor = UIColor.init("#FFFFFF")
        warmingLabel.numberOfLines = 0
        warmingView.addSubview(warmingLabel)
                
        return warmingView
        
    }()
    
    lazy var tabBackView:UIView = {
        
        let tabBackView = UIView(frame: CGRectMake(17.px(), kNavigationBarHeight + 110.px(), kScreenWidth - 34.px(), kScreenHeight - (kNavigationBarHeight + 110.px())))
        tabBackView.backgroundColor = UIColor.init("#FFFAE7")
        
        tabBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBackView.layer.cornerRadius = 30.px()
        tabBackView.layer.masksToBounds = true
        return tabBackView
        
    }()
    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, 0, CGRectGetWidth(self.tabBackView.frame), CGRectGetHeight(self.tabBackView.frame)), style: .plain)
        conTableView.backgroundColor = UIColor.init("#FFFAE7")
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(IDCardTypeCell.self, forCellReuseIdentifier: "IDCardTypeCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        conTableView.tableFooterView = UIView()
        return conTableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.warmingView.frame = CGRectMake(kScreenWidth, kNavigationBarHeight + 26.px(), 283.px(), 59.px())
        UIView.animate(withDuration: 0.55) {
            self.warmingView.frame = CGRectMake(kScreenWidth - 283.px(), kNavigationBarHeight + 26.px(), 283.px(), 59.px())
        }

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
        
        self.view.addSubview(warmingView)
        
  
        
        self.view.addSubview(tabBackView)
        
        tabBackView.addSubview(conTableView)

        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "ID Card Type"
            

        let paramsDic = ["campaign":self.productId,
                         "possibly":AppClassUtilsHelper.getRandomeStrAction(count: 12)]
        
        
        AppNetHelper.get_icon(params: paramsDic) { succ in
            
            
            let conDic = succ.mcneil as! [String:Any]
            let idInfoModle = JSONDeserializer<InfomationModel>.deserializeFrom(dict: conDic)
            self.sourceArr = idInfoModle?.yiette
            self.conTableView.reloadData()
            
            
            
        } fail: { fail in
            
        }

        
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

extension IDCardTypeVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sourceArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:IDCardTypeCell = tableView.dequeueReusableCell(withIdentifier: "IDCardTypeCell", for: indexPath) as! IDCardTypeCell
        cell.lineView.isHidden = indexPath.row == 0 ? true : false
        let model = self.sourceArr?[indexPath.section]
        cell.titleLabel.text = model?.wrinkles;
        let imageUrl = URL(string: model?.goodwill ?? "")
        cell.iconImgView.kf.setImage(with: imageUrl)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chooseIDTypeView:ChooseIDTypeView = ChooseIDTypeView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        
        let model = self.sourceArr?[indexPath.section]
        let tabCon = model?.wrinkles
        chooseIDTypeView.selLabel.text = tabCon
        let imageUrl = URL(string: model?.goodwill ?? "")
        chooseIDTypeView.chooseImgView.kf.setImage(with: imageUrl)
        chooseIDTypeView.selTypeBlockAction { typeStr in
            print("typeSelStr")
            chooseIDTypeView.removeFromSuperview()
            let vc = IDVerificationVC()
            vc.productId = self.productId;
            vc.orderStr = self.orderStr
            vc.idTypeStr = typeStr;
//            vc.chooseTypeBtn.setTitle(typeStr, for: .normal)
            self.navigationController?.pushViewController(vc, animated: true)

            let endTime = DeviceInfoManager.getCurrentMillis();

            let postParams:[String:String] = [
                "judicial": self.productId, // 产品ID
                "triangle": "2",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": self.startTime , // 开始时间
                "quicker": endTime ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 认证选择信息 \(postParams)")
            
            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 认证选择信息 成功")

            } fail: { fail in
                print("aaa  -- 上报 认证选择信息 失败")

            }

            
//            self.selTypeBlock!(typeStr)
//            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(chooseIDTypeView)
        
    }
    
    
    func selTypeBlockAction(block: @escaping IDCardTypeVCBlockClass) -> Void {
        self.selTypeBlock = block
    }
    
    
}
