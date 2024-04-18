//
//  AccountsettingsVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

class AccountsettingsVC: BaseVC {
    
    lazy var topView:UIView = {
        let topView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 136.px()))
        topView.backgroundColor = UIColor.clear
        
       
        return topView
    }()
    

       lazy var conTableView: UITableView = {
           let conTableView = UITableView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight), style: .plain)
           conTableView.backgroundColor = UIColor.clear
           conTableView.delegate = self;
           conTableView.dataSource = self;
           conTableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
           conTableView.separatorStyle = .none
           conTableView.showsVerticalScrollIndicator = false
           conTableView.tableFooterView = UIView()
           conTableView.tableHeaderView = self.topView
           return conTableView
       }()
       
  
       
      
       
       
       override func viewDidLoad() {
           super.viewDidLoad()

           let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight + 136.px()))
           bgView.backgroundColor = UIColor.init("#FFF2E0")
           self.view.addSubview(bgView)
           
           let topImgView = UIImageView(image: UIImage(named: "mine_bg_yanzheng"))
           topImgView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 136.px())
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
       
           
           self.view.addSubview(self.conTableView)
   
           self.addBackBtnAction()
           self.addTitleLabelAction()
           self.titlelabel.text = "Account settings"
           
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
   extension AccountsettingsVC :UITableViewDelegate, UITableViewDataSource{
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 2
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 90.px()
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
           cell.selectionStyle = .none
           cell.conImgView.isHidden = true
           if (indexPath.row == 0){
               cell.titLabel.text = "Sign out"
           }else if (indexPath.row == 1){
               cell.titLabel.text = "Delete account"
           }
           return cell
           
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if (indexPath.row == 0){
               let offView = LogOutView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
               offView.selblockAction {

                   
                   let params = ["drinking":AppClassUtilsHelper.getRandomeStrAction(count: 10), "relief":AppClassUtilsHelper.getRandomeStrAction(count: 10)]

                   AppNetHelper.post_abovegroundAction(params: params) { succ in
                       AppClassUtilsHelper.delUserDefault(key: "mongyeF")
                       AppClassUtilsHelper.delUserDefault(key: sessionUser)
                       AppClassUtilsHelper.delUserDefault(key: mobileUser)
                       
                       AppClassUtilsHelper.delUserDefault(key: isUploadLogin)
                       AppClassUtilsHelper.delUserDefault(key: GetCodetTimeKey)
                       AppClassUtilsHelper.delUserDefault(key: LoginSuccessKey)
                       
                       self.navigationController?.tabBarController?.selectedIndex = 0
                       self.navigationController?.popToRootViewController(animated: false)

                   } fail: { fail in

                   }

                   
               }
               self.view.addSubview(offView)
           }else if indexPath.row == 1{
               let offView = LogOffPopView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
               
               offView.selblockAction {
                   let params = ["chant":AppClassUtilsHelper.getRandomeStrAction(count: 10)]

                   AppNetHelper.post_paperworkStairwellAction(params: params) { succ in
                       AppClassUtilsHelper.delUserDefault(key: "mongyeF")
                       AppClassUtilsHelper.delUserDefault(key: sessionUser)
                       AppClassUtilsHelper.delUserDefault(key: mobileUser)
                       
                       AppClassUtilsHelper.delUserDefault(key: isUploadLogin)
                       AppClassUtilsHelper.delUserDefault(key: GetCodetTimeKey)
                       AppClassUtilsHelper.delUserDefault(key: LoginSuccessKey)
                       
                       self.navigationController?.tabBarController?.selectedIndex = 0
                       self.navigationController?.popToRootViewController(animated: false)

                   } fail: { fail in

                   }
               }
               
               self.view.addSubview(offView)
               
               
           }
       }
       
   }
