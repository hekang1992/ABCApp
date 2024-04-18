//
//  AlertDescView.swift
//  ABCApp
//
//  Created by apple on 2024/4/1.
//

import UIKit

class AlertDescView: UIView {
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    
    lazy var sc: UIScrollView = {
        let sc = UIScrollView()
        sc.showsVerticalScrollIndicator = false
        sc.showsHorizontalScrollIndicator = false
        sc.contentInsetAdjustmentBehavior = .never
        sc.contentSize = CGSize(width: 0, height: 1100.px())
        return sc
    }()
    
    lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.isUserInteractionEnabled = true
        iconImage.contentMode = .scaleAspectFill
        iconImage.image = UIImage(named: "bg123")
        return iconImage
    }()
    
    lazy var iconImage1: UIImageView = {
        let iconImage = UIImageView()
        iconImage.isUserInteractionEnabled = true
        iconImage.image = UIImage(named: "banner123")
        return iconImage
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init("#FFFAE7")
        bgView.layer.cornerRadius = 15.px()
        return bgView
    }()
    
    lazy var iconImage2: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "imagine1543f")
        return iconImage
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel()
        label1.text = "1.Face ID & Personal Details "
        label1.textAlignment = .left
        label1.textColor = UIColor.init("#299F2D")
        label1.font = UIFont(name: kOSBold, size: 16.px())
        return label1
    }()
    
    lazy var label2: UILabel = {
        let label1 = UILabel()
        label1.text = "Complete identity verification to view your exclusive limit.The specific amount is subject to verification results"
        label1.textAlignment = .left
        label1.numberOfLines = 0
        label1.textColor = UIColor.init("#DDAE02")
        label1.font = UIFont(name: kOSRegular, size: 13.px())
        return label1
    }()
    
    lazy var iconImage3: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "imagine25ft")
        return iconImage
    }()
    
    lazy var label3: UILabel = {
        let label1 = UILabel()
        label1.text = "2.Recipient's Account Information"
        label1.textAlignment = .left
        label1.textColor = UIColor.init("#299F2D")
        label1.font = UIFont(name: kOSBold, size: 16.px())
        return label1
    }()
    
    lazy var label4: UILabel = {
        let label1 = UILabel()
        label1.text = "Applying for a loan is as simple as filling out your receiving account information."
        label1.textAlignment = .left
        label1.numberOfLines = 0
        label1.textColor = UIColor.init("#DDAE02")
        label1.font = UIFont(name: kOSRegular, size: 13.px())
        return label1
    }()
    
    lazy var bgView1: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init("#FFFAE7")
        bgView.layer.cornerRadius = 15.px()
        return bgView
    }()
    
    lazy var label5: UILabel = {
        let label1 = UILabel()
        label1.text = "2.Apply and await disbursement"
        label1.textAlignment = .left
        label1.textColor = UIColor.init("#299F2D")
        label1.font = UIFont(name: kOSBold, size: 16.px())
        return label1
    }()
    
    lazy var label6: UILabel = {
        let label1 = UILabel()
        label1.text = "After applying for the loan, please patiently wait for the disbursement."
        label1.textAlignment = .left
        label1.numberOfLines = 0
        label1.textColor = UIColor.init("#DDAE02")
        label1.font = UIFont(name: kOSRegular, size: 13.px())
        return label1
    }()
    
    lazy var iconImage4: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "imagine3fr")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        iconImage.isUserInteractionEnabled = true
        iconImage.addGestureRecognizer(tapGesture)
        return iconImage
    }()
    
    lazy var iconImage5: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "bg_applyfda")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        iconImage.isUserInteractionEnabled = true
        iconImage.addGestureRecognizer(tapGesture)
        return iconImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sc)
        sc.addSubview(iconImage)
        iconImage.addSubview(iconImage1)
        iconImage.addSubview(bgView)
        iconImage.addSubview(iconImage2)
        bgView.addSubview(label1)
        bgView.addSubview(label2)
        bgView.addSubview(iconImage3)
        bgView.addSubview(label3)
        bgView.addSubview(label4)
        iconImage.addSubview(bgView1)
        bgView1.addSubview(label5)
        bgView1.addSubview(label6)
        iconImage.addSubview(iconImage5)
        iconImage.addSubview(iconImage4)
        sc.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImage.snp.makeConstraints { make in
            make.edges.equalTo(sc)
        }
        iconImage1.snp.makeConstraints { make in
            make.top.equalTo(iconImage)
            make.centerX.equalTo(iconImage)
            make.size.equalTo(CGSize(width: 375.px(), height: 136.px()))
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage)
            make.top.equalTo(iconImage1.snp.bottom).offset(141.px())
            make.size.equalTo(CGSizeMake(315.px(), 495.px()))
        }
        iconImage2.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage)
            make.top.equalTo(iconImage1.snp.bottom).offset(75.px())
            make.size.equalTo(CGSize(width: 315.px(), height: 215.px()))
        }
        label1.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(22.px())
            make.top.equalTo(iconImage2.snp.bottom).offset(12.px())
            make.height.equalTo(22.px())
        }
        label2.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(label1.snp.bottom).offset(7.px())
            make.left.equalTo(bgView).offset(42.px())
        }
        iconImage3.snp.makeConstraints { make in
            make.right.equalTo(bgView).offset(-25.px())
            make.top.equalTo(label2.snp.bottom)
            make.size.equalTo(CGSize(width: 332.px(), height: 150.px()))
        }
        label3.snp.makeConstraints { make in
            make.left.equalTo(bgView).offset(22.px())
            make.top.equalTo(iconImage3.snp.bottom).offset(8.px())
            make.height.equalTo(22.px())
        }
        label4.snp.makeConstraints { make in
            make.centerX.equalTo(bgView)
            make.top.equalTo(label3.snp.bottom).offset(7.px())
            make.left.equalTo(bgView).offset(42.px())
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalTo(iconImage)
            make.top.equalTo(bgView.snp.bottom).offset(20.px())
            make.size.equalTo(CGSizeMake(315.px(), 110.px()))
        }
        label5.snp.makeConstraints { make in
            make.left.equalTo(bgView1).offset(22.px())
            make.top.equalTo(bgView1).offset(19.px())
            make.height.equalTo(22.px())
        }
        label6.snp.makeConstraints { make in
            make.centerX.equalTo(bgView1)
            make.top.equalTo(label5.snp.bottom).offset(7.px())
            make.left.equalTo(bgView1).offset(42.px())
        }
        iconImage5.snp.makeConstraints { make in
            make.left.bottom.equalTo(iconImage)
            make.size.equalTo(CGSize(width: 165.px(), height: 241.px()))
        }
        iconImage4.snp.makeConstraints { make in
            make.right.bottom.equalTo(iconImage)
            make.left.equalTo(iconImage5.snp.right)
            make.height.equalTo(241.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            if imageView == iconImage4 {
                print("Image 4 tapped!")
                self.block1!()
            }else {
                self.block2!()
                print("Image 5 tapped!")
            }
        }
    }
    
}
