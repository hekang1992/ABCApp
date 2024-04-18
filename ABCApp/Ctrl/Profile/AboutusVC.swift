//
//  AboutusVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

class AboutusVC: BaseVC{
    
    lazy var topView:UIView = {
        let topView = UIView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, 164.px()))
        topView.backgroundColor = UIColor.clear
        
        let topBgView = UIView(frame: CGRectMake(0, 105.px(), 230.px(), 59.px()))
        topBgView.backgroundColor = UIColor.white
        DeviceInfoManager.addRoundedRect(to: topBgView, topLeft: 0, topRight: 15.px(), bottomLeft: 0, bottomRight: 50.px())
        topView.addSubview(topBgView)
        
        let topLogoImgView = UIImageView(frame: CGRectMake(17.px(), 88.px(), 60.px(), 60.px()))
        topLogoImgView.backgroundColor = UIColor.init("#299F2D")
        topLogoImgView.layer.masksToBounds = true
        topLogoImgView.layer.cornerRadius = 15.px()
        topLogoImgView.image = UIImage(named: "lll123")
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
    
    lazy var conView: UIView = {
        let conView = UIView(frame: CGRectMake(17.px(), 20.px() + CGRectGetMaxY(topView.frame), 341.px(), 366.px()))
        conView.layer.masksToBounds = true
        conView.layer.cornerRadius = 15.px()
        conView.backgroundColor = UIColor.init("#FFFAE7")
        
        let left1Label = UILabel(frame: CGRectMake(15.px(), 23.px(), 220.px(), 33.px()))
        left1Label.textColor = UIColor.init("#263738")
        left1Label.font = UIFont(name: kOSRegular, size: 24.px())
        left1Label.text = "Company"
        conView.addSubview(left1Label)
        
        let right1Label = UILabel(frame: CGRectMake(341.px() - 235.px(), 31.px(), 220.px(), 22.px()))
        right1Label.textColor = UIColor.init("#299F2D")
        right1Label.font = UIFont(name: kOSRegular, size: 16.px())
        right1Label.text = "WONDER5 LENDING CORPORATION."
        right1Label.textAlignment = .right
        conView.addSubview(right1Label)
        
        let line1View = UIView(frame: CGRectMake(15.px(), 61.px(), 311.px(), 1.px()))
        line1View.backgroundColor = UIColor.init("#302C2C")
        conView.addSubview(line1View)
        
        let left2Label = UILabel(frame: CGRectMake(15.px(), CGRectGetMaxY(line1View.frame) + 30.px(), 220.px(), 33.px()))
        left2Label.textColor = UIColor.init("#263738")
        left2Label.font = UIFont(name: kOSRegular, size: 24.px())
        left2Label.text = "SEC Registration"
        conView.addSubview(left2Label)
        
        let right2Label = UILabel(frame: CGRectMake(341.px() - 235.px(), CGRectGetMaxY(line1View.frame) + 38.px(), 220.px(), 22.px()))
        right2Label.textColor = UIColor.init("#299F2D")
        right2Label.font = UIFont(name: kOSRegular, size: 16.px())
        right2Label.text = "No. CS201609295"
        right2Label.textAlignment = .right
        conView.addSubview(right2Label)
        
        let line2View = UIView(frame: CGRectMake(15.px(), CGRectGetMaxY(line1View.frame) + 68.px(), 311.px(), 1.px()))
        line2View.backgroundColor = UIColor.init("#302C2C")
        conView.addSubview(line2View)
        
        let left3Label = UILabel(frame: CGRectMake(15.px(), CGRectGetMaxY(line2View.frame) + 30.px(), 220.px(), 33.px()))
        left3Label.textColor = UIColor.init("#263738")
        left3Label.font = UIFont(name: kOSRegular, size: 24.px())
        left3Label.text = "Certificate of Authority"
        conView.addSubview(left3Label)
        
        let right3Label = UILabel(frame: CGRectMake(341.px() - 235.px(), CGRectGetMaxY(line2View.frame) + 38.px(), 220.px(), 22.px()))
        right3Label.textColor = UIColor.init("#299F2D")
        right3Label.font = UIFont(name: kOSRegular, size: 16.px())
        right3Label.text = "No.1848"
        right3Label.textAlignment = .right
        conView.addSubview(right3Label)
        
        let line3View = UIView(frame: CGRectMake(15.px(), CGRectGetMaxY(line2View.frame) + 68.px(), 311.px(), 1.px()))
        line3View.backgroundColor = UIColor.init("#302C2C")
        conView.addSubview(line3View)
        //
        let left4Label = UILabel(frame: CGRectMake(15.px(), CGRectGetMaxY(line3View.frame) + 30.px(), 220.px(), 33.px()))
        left4Label.textColor = UIColor.init("#263738")
        left4Label.font = UIFont(name: kOSRegular, size: 24.px())
        left4Label.text = "Address"
        conView.addSubview(left4Label)
        
        let right4Label = UILabel(frame: CGRectMake(341.px() - 235.px(), CGRectGetMaxY(line3View.frame) + 10.px(), 220.px(), 50.px()))
        right4Label.textColor = UIColor.init("#299F2D")
        right4Label.font = UIFont(name: kOSRegular, size: 16.px())
        right4Label.text = "Mariners Plaza Building, 1 Peneyra Rd, Barangay San Pedro, Puerto Princesa, 5300 Palawan, Philippines"
        right4Label.textAlignment = .right
        right4Label.numberOfLines = 0
        conView.addSubview(right4Label)
        
        let line4View = UIView(frame: CGRectMake(15.px(), CGRectGetMaxY(line3View.frame) + 68.px(), 311.px(), 1.px()))
        line4View.backgroundColor = UIColor.init("#302C2C")
        conView.addSubview(line4View)
        //
        let left5Label = UILabel(frame: CGRectMake(15.px(), CGRectGetMaxY(line4View.frame) + 30.px(), 220.px(), 33.px()))
        left5Label.textColor = UIColor.init("#263738")
        left5Label.font = UIFont(name: kOSRegular, size: 24.px())
        left5Label.text = "Website"
        conView.addSubview(left5Label)
        
        let right5Label = UILabel(frame: CGRectMake(341.px() - 235.px(), CGRectGetMaxY(line4View.frame) + 38.px(), 220.px(), 22.px()))
        right5Label.textColor = UIColor.init("#299F2D")
        right5Label.font = UIFont(name: kOSRegular, size: 16.px())
        right5Label.text = "https://www.wonder5lend.com/"
        right5Label.textAlignment = .right
        conView.addSubview(right5Label)
        
        let line5View = UIView(frame: CGRectMake(15.px(), CGRectGetMaxY(line4View.frame) + 68.px(), 311.px(), 1.px()))
        line5View.backgroundColor = UIColor.init("#302C2C")
        conView.addSubview(line5View)
        
        return conView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + 136.px()))
        bgView.backgroundColor = UIColor.init("#FFF2E0")
        self.view.addSubview(bgView)
        
        let topImgView = UIImageView(image: UIImage(named: "mine_bg_yanzheng"))
        topImgView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 136.px())
        //           topImgView.isUserInteractionEnabled = true
        //           topImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(se)))
        self.view.addSubview(topImgView)
        
        
        let backView = UIView()
        backView.frame = CGRectMake(0, CGRectGetMaxY(topImgView.frame), kScreenWidth, kScreenHeight - kNavigationBarHeight - 136.px())
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backView.layer.addSublayer(bgLayer1)
        
        self.view.addSubview(backView)
        
        self.view.addSubview(topView)
        
        self.view.addSubview(conView)
        
        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "About us"
        netWorkingMethod()
    }
    
    private func netWorkingMethod() {
        AppNetHelper.get_kefudianhuaAction { [weak self] model in
            if let mcneilDict = model.mcneil as? [String: Any],
               let unfathomable = mcneilDict["unfathomable"] as? String {
                let mobileStr = AppClassUtilsHelper.getDefaultStrWith(key: mobileUser)
                self?.numLabel.text = mobileStr
            } else {
                print("Unfathomable not found or not a string.")
            }
        } fail: { [weak self] model in
            self?.numLabel.text = ""
        }
    }
}

extension AboutusVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.selectionStyle = .none
        cell.conImgView.isHidden = true
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
        return cell
    }
}


