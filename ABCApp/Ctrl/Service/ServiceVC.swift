//
//  ServiceVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/23.
//

import UIKit
import HandyJSON
import MessageUI

class ServiceVC: BaseMainVC {
    
    lazy var warmingView:UIView = {
        
        let warmingView = UIView(frame: CGRectMake(0, 205.px(), 328.px(), 59.px()))
        
        warmingView.backgroundColor = UIColor.init("#299F2D")
        warmingView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        warmingView.layer.cornerRadius = 15.px()
        
        let backView = UIImageView(image: UIImage(named: "icon_tostIdType"))
        backView.frame = CGRectMake(303.px(), 20.px(), 5.px(), 19.px())
        warmingView.addSubview(backView)
        
        let warmingLabel = UILabel(frame: CGRectMake(17.px(), 0.px(), 270.px(), 59.px()))
        warmingLabel.text = "Please provide your account information when contacting us for troubleshooting purposes."
        warmingLabel.font =  UIFont(name: kOSRegular, size: 15.px())
        warmingLabel.textColor = UIColor.init("#FFFFFF")
        warmingLabel.numberOfLines = 0
        warmingView.addSubview(warmingLabel)
                
        return warmingView
        
    }()
    
    
    var dataArr :[FaceModel?] = []

    
    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, kNavigationBarHeight + 185.px(), kScreenWidth, kScreenHeight - kNavigationBarHeight - kCustomTabBarHeight - 185.px()), style: .plain)
        conTableView.backgroundColor = .clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false
        
        return conTableView
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let mobileStr = AppClassUtilsHelper.getDefaultStrWith(key: mobileUser)
        
        AppNetHelper.post_andWhereAction(params: ["precedent":AppClassUtilsHelper.getRandomeStrAction(count: 10)]) { succ in
            
            let conArr = succ.mcneil as! Array<Any>
            let infoArr:[FaceModel?] = JSONDeserializer<FaceModel>.deserializeModelArrayFrom(array: conArr)!
            
            self.dataArr = infoArr
            self.conTableView.reloadData()
            print("111")
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
        self.warmingView.frame = CGRectMake(-328.px(), 205.px(), 328.px(), 59.px())
        UIView.animate(withDuration: 0.55) {
            self.warmingView.frame = CGRectMake(0.px(), 205.px(), 328.px(), 59.px())
        }
        
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
        self.view.addSubview(warmingView)
        self.left3View.iconImg.image = UIImage.init(named: "icon_service_selected")
        self.left3View.setSelAction()
        
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
extension ServiceVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        cell.conImgView.isHidden = false
        let model = self.dataArr[indexPath.row]
        cell.titLabel.text = model?.reelection
        
        cell.conImgView.kf.setImage(with: URL(string: model?.speech ?? ""))
        
//        cell.conImgView.isHidden = true
//        if (indexPath.row == 0){
//            cell.conImgView.isHidden = false
//            cell.titLabel.text = "Phone"
//            cell.conImgView.image = UIImage(named: "image_phonenumber")
//        }else if (indexPath.row == 1){
//            cell.conImgView.isHidden = false
//            cell.titLabel.text = "Mail"
//            cell.conImgView.image = UIImage(named: "service_mail")
//        }else if (indexPath.row == 2){
//            cell.conImgView.isHidden = false
//            cell.titLabel.text = "Message"
//            cell.conImgView.image = UIImage(named: "service_msg")
//        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArr[indexPath.row]

        if (model?.wrinkles == "phone"){
            let urlStr = "tel://"+(model?.swelled ?? "")
            guard let Url = URL(string: urlStr) else { return  }
            UIApplication.shared.open(Url) { succ in
            }
        }else if (model?.wrinkles == "email"){
            let urlStr = "Mailto://"+(model?.swelled ?? "")
            guard let Url = URL(string: urlStr) else { return  }
            UIApplication.shared.open(Url) { succ in
            }
                
            
        }else if (model?.wrinkles == "whatsapp"){
            let urlStr = "whatsapp://send?phone="+(model?.swelled ?? "") + "&text=IPPrestamo"

            
            guard let Url = URL(string: urlStr) else { return  }
            UIApplication.shared.open(Url) { succ in
                if (succ == false){
                    AppClassUtilsHelper.makeTopHudidAction(str: "Please install the WhatsApp application first.")
                }
            }

        }
    }
    
}

