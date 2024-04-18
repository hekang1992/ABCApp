//
//  AddressPopViewCell.swift
//  ABCApp
//
//  Created by Boris on 2024/2/2.
//

import UIKit

class AddressPopViewCell: UITableViewCell {


    lazy var addressLabel: UILabel = {
        
        let addressLabel = UILabel(frame: CGRectMake(0, 0, kScreenWidth - 30.px(), 44.px()))
        addressLabel.font = UIFont(name: kOSBold, size: 16.px())
        addressLabel.textAlignment = .center
        return addressLabel
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.addSubview(addressLabel)
        
        let lineView = UIView(frame: CGRectMake(0, 0, kScreenWidth - 30.px(), 1.px()))
        lineView.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(lineView)
        
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
