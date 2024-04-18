//
//  ProfileCell.swift
//  ABCApp
//
//  Created by Boris on 2024/1/26.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    lazy var titLabel: UILabel = {
        let titLabel = UILabel(frame: CGRectMake(25.px(), 19.px(), 266.px(), 33.px()))
        titLabel.textColor = UIColor.init("#263738")
        titLabel.font = UIFont(name: kOSBold, size: 24.px())
        titLabel.text = "Orders";
        return titLabel
    }()
    
    lazy var conImgView: UIImageView = {
        let conImgView = UIImageView(frame: CGRectMake(341.px() - 66.px(), 0.px(), 76.px(), 70.px()))
        return conImgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        let bgView = UIView.init(frame: CGRectMake(17.px(), 20.px(), 341.px(), 70.px()));
        bgView.backgroundColor = UIColor.white
        DeviceInfoManager.addRoundedRect(to: bgView, topLeft: 15.px(), topRight: 15.px(), bottomLeft: 15.px(), bottomRight: 50.px())

        self.contentView.addSubview(bgView)
        
        bgView.addSubview(self.titLabel)
        bgView.addSubview(self.conImgView)
        
        
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
