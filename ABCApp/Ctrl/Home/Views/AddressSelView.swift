//
//  AddressSelView.swift
//  ABCApp
//
//  Created by Boris on 2024/2/2.
//

import UIKit
typealias AddressPopViewSelBlockClass = (_ addressStr:String) -> ()

class AddressPopView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var hasThir: Int = 0
    var address1: String = ""
    var address2: String = ""
    var address3: String = ""

    var conArrSource: [AddressModel] = []
    var conArrSourceSec: [AddressModel] = []
    var conArrSourceThir: [AddressModel] = []

    var addressSelBlock: AddressPopViewSelBlockClass?

    
    lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.frame = CGRect(x: (0.px()), y: (0.px()), width: (kScreenWidth - 50.px()) / 2, height: (50.px()))
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont(name: kOSRegular, size: (18.px()))
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()

    lazy var confirmBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Confirm", for: .normal)
        button.frame = CGRect(x: (0.px()), y: (0.px()), width: (kScreenWidth - 50.px()) / 2, height: (50.px()))
        button.setTitleColor(UIColor(hexString: "#299F2D"), for: .normal)
        button.titleLabel?.font = UIFont(name: kOSBold, size: (18.px()))
        button.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        return button
    }()

    lazy var selLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (0.px()), y: (10.px()), width: kScreenWidth - (30.px()), height: 23.px()))
        label.font = UIFont(name: kOSBold, size: (16.px()))
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#666666")
        return label
    }()

    lazy var conScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: (40.px()), width: kScreenWidth - 30.px(), height: 340.px() - (65.px())))
        scrollView.contentSize = CGSize(width: (kScreenWidth - 30.px()) * 2, height: 340.px() - (65.px()))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.addSubview(self.conTableView1)
        scrollView.addSubview(self.conTableView2)
        scrollView.addSubview(self.conTableView3)
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    lazy var conTableView1: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 30.px(), height: 340.px() - (65.px())), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AddressPopViewCell.self, forCellReuseIdentifier: "AddressPopViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    lazy var conTableView2: UITableView = {
        let tableView = UITableView(frame: CGRect(x: kScreenWidth - 30.px(), y: 0, width: kScreenWidth - 30.px(), height: 340.px() - (65.px())), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressPopViewCell.self, forCellReuseIdentifier: "AddressPopViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    lazy var conTableView3: UITableView = {
        let tableView = UITableView(frame: CGRect(x: (kScreenWidth - 30.px()) * 2, y: 0, width: kScreenWidth - 30.px(), height: 340.px() - (65.px())), style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressPopViewCell.self, forCellReuseIdentifier: "AddressPopViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.isHidden = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.hasThir = 0
        
        self.backgroundColor = UIColor.init(hexString: "#555555", alpha: 0.5)
        let conView = UIView(frame: CGRectMake(15.px(), kScreenHeight - 450.px(), kScreenWidth - 30.px(), 340.px()))
        conView.backgroundColor = UIColor.clear
        conView.layer.masksToBounds = true
        conView.layer.cornerRadius = 15.px()
        self.addSubview(conView)
        
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRectMake(0, 0, kScreenWidth - 30.px() , 340.px())
        
        conView.addSubview(effectView)
        

        conView.addSubview(selLabel)
        conView.addSubview(conScrollView)
        
        
        let cancelView = UIVisualEffectView(effect: effect)
        cancelView.frame = CGRectMake(15.px(), CGRectGetMaxY(conView.frame) + 20.px(), (kScreenWidth - 50.px()) / 2 , 50.px())
        cancelView.layer.masksToBounds = true
        cancelView.layer.cornerRadius = 15.px()
        self.addSubview(cancelView)
        
        let doneView = UIVisualEffectView(effect: effect)
        doneView.frame = CGRectMake(CGRectGetMaxX(cancelView.frame) + 20.px(), CGRectGetMaxY(conView.frame) + 20.px(), (kScreenWidth - 50.px()) / 2 , 50.px())
        doneView.layer.masksToBounds = true
        doneView.layer.cornerRadius = 15.px()
        self.addSubview(doneView)
        
        cancelView.contentView.addSubview(cancelBtn)
        doneView.contentView.addSubview(confirmBtn)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 省略其他方法...

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == self.conTableView1){
            return self.conArrSource.count;
        }
        if (tableView == self.conTableView2){
            return self.conArrSourceSec.count;
        }
        if (tableView == self.conTableView3){
            return self.conArrSourceThir.count;
        }
        return 0;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.px()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:AddressPopViewCell = tableView.dequeueReusableCell(withIdentifier: "AddressPopViewCell", for: indexPath) as! AddressPopViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        if (tableView == self.conTableView1){
            let conModel:AddressModel = self.conArrSource[indexPath.row]
            cell.addressLabel.text = conModel.formed;
            if (self.address1 == conModel.formed){
                cell.addressLabel.backgroundColor = UIColor.init("#299F2D");
                cell.addressLabel.textColor = UIColor.white;
            }else{
                cell.addressLabel.backgroundColor = UIColor.clear
                cell.addressLabel.textColor = UIColor.init("#333333")
            }
            
        }else if (tableView == self.conTableView2){
            
            let conModel:AddressModel = self.conArrSourceSec[indexPath.row]
            cell.addressLabel.text = conModel.formed;
            if (self.address2 == conModel.formed){
                cell.addressLabel.backgroundColor = UIColor.init("#299F2D");
                cell.addressLabel.textColor = UIColor.white;
            }else{
                cell.addressLabel.backgroundColor = UIColor.clear
                cell.addressLabel.textColor = UIColor.init("#333333")
            }
            
            
        }else if (tableView == self.conTableView3){
            let conModel:AddressModel = self.conArrSourceThir[indexPath.row]
            cell.addressLabel.text = conModel.formed;
            if (self.address3 == conModel.formed){
                cell.addressLabel.backgroundColor = UIColor.init("#299F2D");
                cell.addressLabel.textColor = UIColor.white;
            }else{
                cell.addressLabel.backgroundColor = UIColor.clear
                cell.addressLabel.textColor = UIColor.init("#333333")
            }
            
        }
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (tableView == self.conTableView1){
            
            let conModel:AddressModel = self.conArrSource[indexPath.row]

            self.conArrSourceSec.removeAll()
            self.conArrSourceSec = conModel.sting
            self.conTableView2.reloadData()
//

//
            self.address1 = conModel.formed!;
            self.address2 = "";
            self.address3 = "";
            self.selLabel.text = conModel.formed;

            UIView.animate(withDuration: 0.35) {
                self.conScrollView.contentOffset = CGPointMake((kScreenWidth - 30.px()), 0);
            }
            self.conScrollView.isScrollEnabled = true;
        }else if (tableView == self.conTableView2){
//            
            let conModel:AddressModel = self.conArrSourceSec[indexPath.row]
            self.address2 = conModel.formed!;
            self.address3 = "";
            self.selLabel.text = self.address1 + "-" + self.address2;
            if(conModel.sting.count > 0){
                
                self.hasThir = 1;
                
                self.conArrSourceThir.removeAll()
                self.conArrSourceThir = conModel.sting
                self.conTableView3.reloadData()
                self.conScrollView.contentSize = CGSizeMake((kScreenWidth - 30.px()) * 3, 340.px() - (65.px()));

                UIView.animate(withDuration: 0.35) {
                    self.conScrollView.contentOffset = CGPointMake((kScreenWidth - 30.px()) * 2, 0);
                }

                self.conScrollView.isPagingEnabled = true
                self.conTableView3.isHidden = false;
                
            }else{
         
                self.hasThir = -1;
                
            }
            
            

        }else if (tableView == self.conTableView3){
            
            
            let conModel:AddressModel = self.conArrSourceThir[indexPath.row]
            self.address3 = conModel.formed!;

            self.selLabel.text = self.address1 + "-" + self.address2 + "-" + self.address3;

        }
        tableView.reloadData()

    }
    
    
    @objc func cancelBtnAction() {
        removeFromSuperview()
    }
    
    @objc func confirmBtnAction() {
        
        if(self.address2.count == 0){
            return
        }
        
        if (self.hasThir == 1){
            if(self.address3.count == 0){
                return
            }
        }
        
        
        removeFromSuperview()
        self.addressSelBlock!(self.selLabel.text!)
    }
    
    
    func addressSelBlockAction(block: @escaping AddressPopViewSelBlockClass) -> Void {
        self.addressSelBlock = block
    }
    

}
