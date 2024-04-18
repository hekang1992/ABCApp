//
//  ChooseDateView.swift
//  ABCApp
//
//  Created by Boris on 2024/2/2.
//

import UIKit

typealias ChooseDateViewSelBlockClass = (_ dateStr:String) -> ()



class ChooseDateView: UIView{

    var dateSelBlock: ChooseDateViewSelBlockClass?

    
    var dateStr: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha: 0.5)
        self.addSubview(self.backView)
        self.backView.addSubview(cancelDateBtn)
        self.backView.addSubview(confirmDateBtn)
        self.backView.addSubview(datePickerView) 
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    lazy var backView:UIView = {
        let backView = UIView(frame: CGRectMake(0, kScreenHeight - 340.px(), kScreenWidth, 340.px()))
        backView.backgroundColor = UIColor.white
        return backView
    }()
    

     lazy var cancelDateBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.frame = CGRect(x: 10.px(), y: 5.px(), width: 50.px(), height: 30.px())
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.titleLabel?.font = UIFont(name: kOSRegular, size: 14.px())
        button.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return button
    }()

     lazy var confirmDateBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Confirm", for: .normal)
         button.frame = CGRect(x: kScreenWidth - 70.px(), y: 5.px(), width: 60.px(), height: 30.px())
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
         button.titleLabel?.font = UIFont(name: kOSBold, size: 14.px())
        button.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        return button
    }()

     lazy var datePickerView: UIDatePicker = {
        let picker = UIDatePicker(frame: CGRect(x: kScreenWidth / 2 - (300.px() / 2), y: (40.px()), width: (300.px()), height: (300.px())))
        picker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        }
        return picker
    }()

    @objc private func cancelBtnAction() {
        removeFromSuperview()
    }

    func setDateStr(_ dateStr: String) {
        guard dateStr.isEmpty == false else {
            return
        }
        self.dateStr = dateStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePickerView.setDate(dateFormatter.date(from: dateStr) ?? Date(), animated: false)
    }

    @objc private func confirmBtnAction() {
        let theDate = datePickerView.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateStr = dateFormatter.string(from: theDate)
        self.dateSelBlock!(dateStr)
        removeFromSuperview()
    }
    
    
    func dateSelBlockAction(block: @escaping ChooseDateViewSelBlockClass) -> Void {
        self.dateSelBlock = block
    }
    
}
