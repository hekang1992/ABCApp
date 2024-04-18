//
//  ProfileVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/23.
//

import UIKit
import HandyJSON

class ProfileVC: BaseMainVC {
    
    var appHomeModel:HomeModel? = nil
    
    lazy var topView:UIView = {
        let topView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 164.px()))
        topView.backgroundColor = UIColor.clear
        
        let topBgView = UIView(frame: CGRectMake(0, 105.px(), 230.px(), 59.px()))
        topBgView.backgroundColor = UIColor.white
        DeviceInfoManager.addRoundedRect(to: topBgView, topLeft: 0, topRight: 15.px(), bottomLeft: 0, bottomRight: 50.px())
        topView.addSubview(topBgView)
        
        let topLogoImgView = UIImageView(frame: CGRectMake(17.px(), 88.px(), 60.px(), 60.px()))
        topLogoImgView.image = UIImage(named: "lll123")
        topLogoImgView.backgroundColor = UIColor.init("#299F2D")
        topLogoImgView.layer.masksToBounds = true
        topLogoImgView.layer.cornerRadius = 15.px()
        topView.addSubview(topLogoImgView)
        
        topBgView.addSubview(numLabel)
        
        return topView
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel(frame: CGRectMake(91.px(), 17.px(), 130.px(), 25.px()))
        numLabel.textColor = UIColor.init("#263738")
        numLabel.font = UIFont(name: kOSRegular, size: 18.px())
        return numLabel
    }()
    
    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kCustomTabBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        conTableView.tableFooterView = self.footerView
        conTableView.tableHeaderView = self.topView
        return conTableView
    }()
    
    lazy var footerView:UIView = {
        let footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 100.px()))
        footerView.backgroundColor = UIColor.clear
        
        
        let topLogoImgView = UIImageView(frame: CGRectMake(17.px(), 5.px(), 155.px(), 95.px()))
        topLogoImgView.isUserInteractionEnabled = true
        topLogoImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selBottomAction)))
        topLogoImgView.image = UIImage(named: "mine_Slice 5")
        footerView.addSubview(topLogoImgView)
        
        let textLabel = UILabel(frame: CGRectMake(5.px(), 35.px(), 150.px(), 25.px()))
        textLabel.textColor = UIColor.init("#ffffff")
        textLabel.font = UIFont(name: kOSRegular, size: 18.px())
        textLabel.text = "Account settings"
        textLabel.textAlignment = .center
        topLogoImgView.addSubview(textLabel)
        
        return footerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let mobileStr = AppClassUtilsHelper.getDefaultStrWith(key: mobileUser)
        self.numLabel.text = mobileStr
        AppNetHelper.get_artifactsCondensedAction { [weak self] succ in
            let conDic = succ.mcneil as! [String:Any]
            let homeModel = JSONDeserializer<HomeModel>.deserializeFrom(dict: conDic)
            self?.appHomeModel = homeModel
            self?.conTableView.reloadData()
        } fail: { fail in
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + 136.px()))
        bgView.backgroundColor = UIColor.init("#FFF2E0")
        self.view.addSubview(bgView)
        
        let topImgView = UIImageView(image: UIImage(named: "mine_bg_yanzheng"))
        topImgView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 136.px())
        self.view.addSubview(topImgView)
        
        let backView = UIView()
        backView.frame = CGRectMake(0, CGRectGetMaxY(topImgView.frame), kScreenWidth, kScreenHeight - kNavigationBarHeight - 136.px() - kCustomTabBarHeight)
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backView.layer.addSublayer(bgLayer1)
        
        self.view.addSubview(backView)
        
        
        self.view.addSubview(self.conTableView)
        
        
        self.left4View.iconImg.image = UIImage.init(named: "icon_profile_selected")
        self.left4View.setSelAction()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func selBottomAction() {
        self.navigationController?.pushViewController(AccountsettingsVC(), animated: true)
    }
    
    private func pushH5(url: String) {
        let paramsStr = AppAFNetManager.getPublicParamsAction()
        let webVC = AppWebViewVC()
        webVC.urlStr = ApiPrefix + url + "?" + paramsStr
        navigationController?.pushViewController(webVC, animated: true)
    }
}
extension ProfileVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.appHomeModel?.mongye == "0" {
            return 5
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        cell.conImgView.isHidden = true
        if self.appHomeModel?.mongye == "0" {
            if (indexPath.row == 0){
                cell.conImgView.isHidden = false
                cell.titLabel.text = "Orders"
                cell.conImgView.image = UIImage(named: "mine_image_order")
            }else if (indexPath.row == 1){
                cell.conImgView.isHidden = false
                cell.titLabel.text = "E-wallet & bank card"
                cell.conImgView.image = UIImage(named: "image_Ewallet")
            }else if (indexPath.row == 2){
                cell.conImgView.isHidden = false
                cell.titLabel.text = "About us"
                cell.conImgView.image = UIImage(named: "mine_image_aboutus")
            }else if (indexPath.row == 3){
                cell.titLabel.text = "Privacy Policy"
            }else if (indexPath.row == 4){
                cell.titLabel.text = "Loan Agreement"
            }
        }else{
            if (indexPath.row == 0){
                cell.conImgView.isHidden = false
                cell.titLabel.text = "Orders"
                cell.conImgView.image = UIImage(named: "mine_image_order")
            }else if (indexPath.row == 1){
                cell.conImgView.isHidden = false
                cell.titLabel.text = "About us"
                cell.conImgView.image = UIImage(named: "mine_image_aboutus")
            }else if (indexPath.row == 2){
                cell.titLabel.text = "Privacy Policy"
            }else if (indexPath.row == 3){
                cell.titLabel.text = "Loan Agreement"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.appHomeModel?.mongye == "0" {
            if (indexPath.row == 0){
                self.navigationController?.pushViewController(OrdersVC(), animated: true)
            }else if indexPath.row == 1{
                self.pushH5(url: "/departureWiped")
            }else if indexPath.row == 2{
                self.navigationController?.pushViewController(AboutusVC(), animated: true)
            }else if indexPath.row == 3{
                self.pushH5(url: "/speechesWorse")
            }else if indexPath.row == 4{
                self.pushH5(url: "/smartMarch")
            }
        }else {
            if (indexPath.row == 0){
                self.navigationController?.pushViewController(OrdersVC(), animated: true)
            }else if indexPath.row == 1{
                self.navigationController?.pushViewController(AboutusVC(), animated: true)
            }else if indexPath.row == 2{
                self.pushH5(url: "/speechesWorse")
            }else if indexPath.row == 3{
                self.pushH5(url: "/smartMarch")
            }
        }
        
    }
    
}


