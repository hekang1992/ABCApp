//
//  RootTabBarItem.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

class RootTabBarItem: UIView {

        lazy var iconImg:UIImageView = {
            
            let imgView = UIImageView.init(frame: CGRect.init(x: self.frame.width / 2 - 16.5.px(), y: 17.px(), width: 35.px(), height: 35.px()))
            return imgView
            
        }()
        
        lazy var titleLabel:UILabel = {
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 57.px(), width: self.frame.width,  height: 21.px()))
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.init("#E7BF2D")
            label.text = ""
            label.font = UIFont.init(name: kOSRegular, size: 15.px())
            return label
        }()
        

        override init(frame: CGRect) {
            
            super.init(frame: frame)
            self.addSubview(self.iconImg)
            self.addSubview(self.titleLabel)
            
        }
    
    public func setSelAction (){
        self.titleLabel.textColor = UIColor.init("#299F2D")
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
