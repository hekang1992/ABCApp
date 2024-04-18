//
//  IDCardTypeCell.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

class IDCardTypeCell: UITableViewCell {

    lazy var lineView: UIView = {
        
        let lineView = UIView.init(frame: CGRect.init(x: 15.px(), y: 0, width: 311.px(), height: 2.px()))
        lineView.backgroundColor = UIColor.init("#FFE894")
        lineView.layer.masksToBounds = true;
        lineView.layer.cornerRadius = 7.px()
        return lineView
        
    }()
    
    lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: CGRectMake(15.px(), 12.px(), 125.px(), 77.px()))
        iconImgView.backgroundColor = UIColor.init("#FFEFB8")
        iconImgView.layer.masksToBounds = true;
        iconImgView.layer.cornerRadius = 10.px()
        return iconImgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRectMake(161.px(), 25.px(), 266.px(), 25.px()))
        titleLabel.textColor = UIColor.init("#000000")
        titleLabel.font = UIFont(name: kOSBold, size: 18.px())
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init("#FFFAE7")
        self.contentView.addSubview(iconImgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(self.lineView)
        
        
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
