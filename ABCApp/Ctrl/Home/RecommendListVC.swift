//
//  RecommendListVC.swift
//  ABCApp
//
//  Created by Boris on 2024/3/28.
//

import UIKit
import HandyJSON

class RecommendListVC: BaseVC {

    var dataSource:[RecommendListModel]? = [];
    

    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(Root2ViewCell.self, forCellReuseIdentifier: "Root2ViewCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false

        return conTableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(hexString: "#FFF4CF")

        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "Recommend List"
        self.view.addSubview(self.conTableView)

        self.getRecommendListAction()
        // Do any additional setup after loading the view.
    }
    
    func getRecommendListAction (){
        
        AppNetHelper.get_throughMistakenAction { succ in
            
            let conDic = succ.mcneil as! [String:Any]
            
            
            
            let homeModel = JSONDeserializer<RecommendListModel>.deserializeFrom(dict: conDic)
            self.dataSource = homeModel?.sting
            self.conTableView.reloadData()
            
            
            print("111")
            
        } fail: { fail in
            
        }

        
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
extension RecommendListVC :UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152.px()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Root2ViewCell = tableView.dequeueReusableCell(withIdentifier: "Root2ViewCell", for: indexPath) as! Root2ViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
    
        let indexItem = self.dataSource?[indexPath.row]
        cell.titLabel.text = indexItem?.surging
        cell.conImgView.kf.setImage(with: URL(string: indexItem?.fighting ?? ""))
        cell.selBtn .setTitle(indexItem?.testy, for: .normal)
        cell.subTitLabel.text = indexItem?.wished?.count == 0 ? "Borrowed 0 times!" : indexItem?.wished
        cell.peoImgView.isHidden = indexItem?.inspected == ""

        
        cell.selBtn.backgroundColor = UIColor.init("#299F2D")
        
        if (indexItem?.sensed == "2"){
            cell.selBtn.backgroundColor = UIColor.init("#FF7A00")
        }else if (indexItem?.sensed == "3"){
            cell.selBtn.backgroundColor = UIColor.init("#BCBCBC")
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productModel = self.dataSource?[indexPath.row]
        if (productModel?.raced != nil){

            if (productModel?.raced?.contains("ace://yy.ee/") == true){
                let paramsDic = [
                    "campaign":productModel?.juices ?? "",
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
                        
                        AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: productModel?.juices ?? "", order: detailModel?.concern?.toying ?? "")
                        
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
                AppLaunchUtils.jumpNextVCAction(rootVC: self, route: productModel?.giving! ?? "");
                
            }
            

        }
        
    }
    
}
