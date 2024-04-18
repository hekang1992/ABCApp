//
//  EmergencyContactCell.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

typealias EmergencyContactBlockClass = () -> ()

class EmergencyContactCell: UITableViewCell {
    
    var selTopBlock: EmergencyContactBlockClass?
    var selBottomBlock: EmergencyContactBlockClass?
    

    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(17.px(), 0.px(), 266.px(), 33.px()))
        titLabel.textColor = UIColor.init("#263738")
        titLabel.font = UIFont(name: kOSBold, size: 24.px())
        return titLabel
    }()
    
    lazy var conBackView: UIView = {
        
        let conBackView = UIView(frame: CGRectMake(17.px(), 51.px(), 341.px(), 144.px()))
        conBackView.backgroundColor = UIColor.init("#FFFAE7")
        conBackView.layer.masksToBounds = true
        conBackView.layer.cornerRadius = 15.px()
        
        conBackView.addSubview(topTypeTF)
        conBackView.addSubview(topSelView)
        
        let lineView = UIView(frame: CGRectMake(15.px(), 50.px(), 311.px(), 2.px()))
        lineView.backgroundColor = UIColor.init("#FFE894")
        lineView.layer.cornerRadius = 7.px()
        conBackView.addSubview(lineView)
        conBackView.addSubview(chooseContactTF)
        conBackView.addSubview(mobileTF)
        
        conBackView.addSubview(bottomSelView)
        
        return conBackView
        
    }()
    
    
    lazy var topTypeTF: UITextField = {
        let topTypeTF = UITextField(frame: CGRectMake(0.px(), 0.px(), 341.px(), 50.px()))
        topTypeTF.textColor = UIColor.init("#333333")
        topTypeTF.font = UIFont(name: kOSBold, size: 24.px())
        topTypeTF.isUserInteractionEnabled = false
        topTypeTF.layer.masksToBounds = true
        topTypeTF.layer.cornerRadius = 15.px()
        topTypeTF.backgroundColor = UIColor.clear
        topTypeTF.leftViewMode = .always
        topTypeTF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        
        topTypeTF.rightViewMode = .always
        let rightView = UIView(frame: CGRectMake(0, 0, 60.px(), 50.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 3.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "confirm_popSlice 2")
        rightView.addSubview(backImgView)
        
        topTypeTF.rightView = rightView
        
        let totlaStr = "Relationship";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        topTypeTF.attributedPlaceholder = attributedString
        return topTypeTF
    }()
    
    lazy var topSelView : UIView = {
        
        let conView = UIView(frame: CGRectMake(0, 0, 341.px(), 50.px()))
        conView.backgroundColor = UIColor.clear
        conView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(topSelAction)))
        return conView
        
    }()
    
    
    lazy var chooseContactTF: UITextField = {
        let chooseContactTF = UITextField(frame: CGRectMake(0.px(), 52.px(), 341.px(), 50.px()))
        chooseContactTF.textColor = UIColor.init("#333333")
        chooseContactTF.font = UIFont(name: kOSBold, size: 24.px())
        chooseContactTF.isUserInteractionEnabled = false
        chooseContactTF.layer.masksToBounds = true
        chooseContactTF.layer.cornerRadius = 15.px()
        chooseContactTF.backgroundColor = UIColor.clear
        chooseContactTF.leftViewMode = .always
        chooseContactTF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        
        chooseContactTF.rightViewMode = .always
        let rightView = UIView(frame: CGRectMake(0, 0, 60.px(), 50.px()))
        
        let backImgView = UIImageView(frame: CGRectMake(3.px(), 3.px(), 44.px(), 44.px()))
        backImgView.image = UIImage(named: "icon_connect")
        rightView.addSubview(backImgView)
        
        chooseContactTF.rightView = rightView
        
        let totlaStr = "Name";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        chooseContactTF.attributedPlaceholder = attributedString
        return chooseContactTF
    }()
    

    
    lazy var mobileTF: UITextField = {
        let mobileTF = UITextField(frame: CGRectMake(0.px(), CGRectGetMaxY(chooseContactTF.frame) - 3.px(), 341.px(), 40.px()))
        mobileTF.textColor = UIColor.init("#333333")
        mobileTF.font = UIFont(name: kOSBold, size: 24.px())
        mobileTF.isUserInteractionEnabled = false
        mobileTF.layer.masksToBounds = true
        mobileTF.layer.cornerRadius = 15.px()
        mobileTF.backgroundColor = UIColor.clear
        mobileTF.leftViewMode = .always
        mobileTF.leftView = UIView(frame: CGRectMake(0, 0, 17.px(), 50.px()))
        
        
        let totlaStr = "Mobile";
        let attributedString = NSMutableAttributedString.init(string: totlaStr)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.init("#DDAE02")], range: LoginView.rangeOfString(string: totlaStr as NSString, andInString: (totlaStr as NSString) as String).first!)
        mobileTF.attributedPlaceholder = attributedString
        return mobileTF
    }()
    
    lazy var bottomSelView : UIView = {
        
        let conView = UIView(frame: CGRectMake(0, 51.px(), 341.px(), 90.px()))
        conView.backgroundColor = UIColor.clear
        conView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(bottomSelAction)))
        return conView
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear

        self.contentView.addSubview(self.titLabel)
        self.contentView.addSubview(self.conBackView)
        
        
    }
    
    @objc func topSelAction (){
        print("111")
        self.selTopBlock!()
    }
    
    @objc func bottomSelAction (){
        print("222")
        self.selBottomBlock!()
    }
    
    func selTopblockAction(block: @escaping EmergencyContactBlockClass) -> Void {
        self.selTopBlock = block
    }
    
    func selBottomblockAction(block: @escaping EmergencyContactBlockClass) -> Void {
        self.selBottomBlock = block
    }
    
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
