//
//  Root2View.swift
//  ABCApp
//
//  Created by Boris on 2024/2/28.
//

import UIKit

typealias SelRoot2ViewStrBlock = (_ route:String) -> ()

class Root2View: UIView {
    
    var selProductBlock: SelRoot2ViewStrBlock?
    var selBannerBlock: SelRoot2ViewStrBlock?
    
    var dataSource:[HomeSubModel]? = [];
    var conModel:HomeSubModel?
    
    lazy var topView:UIView = {
        let topView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 268.px()))
        topView.backgroundColor = UIColor.clear
        
        topView.addSubview(self.banner1View)
        topView.addSubview(self.banner2View)
        topView.addSubview(self.textConLabel)

        return topView
    }()
    
    lazy var textConLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(17.px(), 225.px(), 236.px(), 33.px()))
        titLabel.textColor = UIColor.init("#263738")
        titLabel.font = UIFont(name: kOSBold, size: 24.px())
        titLabel.text = "More products"
        
        return titLabel
    }()
    
    
    lazy var banner1View:BannerView = {
        let banner1View = BannerView(frame: CGRectMake(17.px(), 40.px(), kScreenWidth - 34.px(), 65.px()))
        banner1View.backgroundColor = UIColor.white
        banner1View.layer.masksToBounds = true;
        banner1View.layer.cornerRadius = 15.px()
        banner1View.selBannerblockAction{ index in
            
            let resArr = self.conModel?.unspoken?.honorific
            let conModel:HomeSubModel? = resArr?[index]
            if(conModel?.giving != "" && conModel?.giving != nil){
                self.selBannerBlock!(conModel?.giving ?? "")
            }
            
        }
        return banner1View
    }()
    
    
    
    
    lazy var banner2View:BannerView = {
        let banner2View = BannerView(frame: CGRectMake(17.px(), CGRectGetMaxY(self.banner1View.frame) + 15.px(), kScreenWidth - 34.px(), 65.px()))
        banner2View.backgroundColor = UIColor.white
        banner2View.layer.masksToBounds = true
        banner2View.layer.cornerRadius = 15.px()
        
        banner2View.selBannerblockAction{ index in
            
            let resArr = self.conModel?.banner2?.honorific
            let conModel:HomeSubModel? = resArr?[index]
            if(conModel?.giving != "" && conModel?.giving != nil){
                self.selBannerBlock!(conModel?.giving ?? "")
            }
            
        }
        
        return banner2View
    }()
    
    
    lazy var conTableView: UITableView = {
        let conTableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCustomTabBarHeight), style: .plain)
        conTableView.backgroundColor = UIColor.clear
        conTableView.delegate = self;
        conTableView.dataSource = self;
        conTableView.register(Root2ViewCell.self, forCellReuseIdentifier: "Root2ViewCell")
        conTableView.separatorStyle = .none
        conTableView.showsVerticalScrollIndicator = false

        conTableView.tableHeaderView = self.topView
        return conTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.conTableView)
        
    }
    
    


    
    func setConModelAction (){
        
        if (self.conModel?.unspoken != nil){
            
            let resArr = self.conModel?.unspoken?.honorific
            
            var arr:[String] = []
            for resItem:HomeSubModel in resArr! {
                arr.append(resItem.goodwill ?? "")
            }
            self.banner1View.cycleScrollView.imageURLStringsGroup = arr;

            self.banner1View.isHidden = false;

        }else{
            self.banner1View.isHidden = true;
        }
        
        if (self.conModel?.banner2 != nil){
            
            let resArr = self.conModel?.banner2?.honorific
            
            var arr:[String] = []
            for resItem:HomeSubModel in resArr! {
                arr.append(resItem.goodwill ?? "")
            }
            self.banner2View.cycleScrollView.imageURLStringsGroup = arr;

            self.banner2View.isHidden = false;
        }else{
            self.banner2View.isHidden = true;
        }
        
        if (self.banner2View.isHidden == true){
            
            self.textConLabel.frame = CGRectMake(17.px(), 225.px() - 90.px(), 236.px(), 33.px())
            self.topView.frame = CGRectMake(0, 0, kScreenWidth, 268.px() - 90.px())
        }else{
            self.textConLabel.frame = CGRectMake(17.px(), 225.px(), 236.px(), 33.px())
            self.topView.frame = CGRectMake(0, 0, kScreenWidth, 268.px())
        }
        self.conTableView.tableHeaderView = self.topView

    }
    
    func selBannerblockAction(block: @escaping SelRoot2ViewStrBlock) -> Void {
        self.selBannerBlock = block
    }
    
    func selProductblockAction(block: @escaping SelRoot2ViewStrBlock) -> Void {
        self.selProductBlock = block
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension Root2View :UITableViewDelegate, UITableViewDataSource{
    
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
        let indexItem = self.dataSource?[indexPath.row]
        if (indexItem?.giving != nil){
            self.selProductBlock!(indexItem?.juices ?? "")

        }
        
    }
    
}
