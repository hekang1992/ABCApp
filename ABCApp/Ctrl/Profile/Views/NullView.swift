//
//  NullView.swift
//  ABCApp
//
//  Created by Boris on 2024/3/7.
//

import UIKit

class NullView: UIView {

    lazy var imgView:UIImageView = {
        
        let imgView = UIImageView.init(frame: CGRectMake(81.px(), 0, kScreenWidth - 162.px(), 262.px()))
        imgView.image = UIImage(named: "image_nodate")
        return imgView
        
    }()
    
    lazy var bottom2Title: UILabel = {
        let bottom2Title = UILabel(frame: CGRectMake(0.px(), 262.px() + 17.px(), CGRectGetWidth(self.frame), 28.px()))
        bottom2Title.text = "There's nothing here ... ..."
        bottom2Title.font = UIFont(name: kOSRegular, size: 16.px())
        bottom2Title.textColor = UIColor.init("#DEAF03")
        bottom2Title.textAlignment = .center
        return bottom2Title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imgView)
        self.addSubview(self.bottom2Title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
