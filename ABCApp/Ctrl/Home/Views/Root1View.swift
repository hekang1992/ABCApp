//
//  Root1View.swift
//  ABCApp
//
//  Created by Boris on 2024/1/23.
//

import UIKit

typealias SelRoot1ViewBlock = () -> ()

class Root1View: UIView {
    
    var selBlock: SelRoot1ViewBlock?


    lazy var conScrollowView:UIScrollView = {
        let conScrollowView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame)))
        conScrollowView.contentSize = CGSize(width: kScreenWidth, height: 812.px() - kCustomTabBarHeight)
        conScrollowView.showsVerticalScrollIndicator = false
        conScrollowView.contentInsetAdjustmentBehavior = .never
                
        let backImg = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 812.px()))
        backImg.image = UIImage(named:"bg_home")
        conScrollowView .addSubview(backImg)
      
        let banner_home1 = UIImageView(frame: CGRectMake(0.px(), 0.px(), kScreenWidth, 135.px()))
        banner_home1.image = UIImage(named:"banner_home1")
        
        let applyLabel = UILabel(frame: CGRectMake(52.px(), 73.px(), 271.px(), 30.px()))
        applyLabel.font = UIFont(name: kOSBold, size: 28.px())
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init("#614B20")
        applyLabel.text = "Welcome to  Ace Cash";
        banner_home1.addSubview(applyLabel)
        
        conScrollowView .addSubview(banner_home1)
        
        
        
        let bg_treeImg = UIImageView(frame: CGRectMake(63.px(), 122.px(), 221.px(), 484.px()))
        bg_treeImg.image = UIImage(named:"bg_tree")
        conScrollowView .addSubview(bg_treeImg)
        
        conScrollowView.addSubview(self.topConImgView)
        
        let bg_loanterm = UIImageView(frame: CGRectMake(21.px(), 414.px(), 331.px(), 91.px()))
        bg_loanterm.image = UIImage(named:"bg_loanterm")
        conScrollowView .addSubview(bg_loanterm)
        bg_loanterm.addSubview(self.bottom1Title)
        bg_loanterm.addSubview(self.bottom2Title)
        bg_loanterm.addSubview(self.bottom1Desc)
        bg_loanterm.addSubview(self.bottom2Desc)
        
        let loantermBG = UIImageView(frame: CGRectMake(124.px(), 0.px(), 205.px(), 91.px()))
        loantermBG.image = UIImage(named:"bg_shadow")
        bg_loanterm .addSubview(loantermBG)
        
        
        bg_loanterm.isUserInteractionEnabled = true
        bg_loanterm.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTapAction)))
        
        conScrollowView .addSubview(self.applyImgView)
        
        return conScrollowView
    }()
    
    lazy var applyImgView: UIImageView = {
        let applyImgView = UIImageView(frame: CGRectMake(158.px(), 593.px(), 200.px(), 187.px()))
        applyImgView.image = UIImage(named:"bg_apply")
//        applyImgView.addSubview(self.applyLabel)
        
        applyImgView.isUserInteractionEnabled = true
        applyImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTapAction)))
        
        return applyImgView
    }()
    
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel(frame: CGRectMake(0.px(), 46.px(), 188.px(), 49.px()))
        applyLabel.font = UIFont(name: kOSBold, size: 35.px())
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.white
        return applyLabel
    }()
    
    
    lazy var bottom1Title: UILabel = {
        let bottom1Title = UILabel(frame: CGRectMake(20.px(), 18.px(), 150.px(), 22.px()))
//        bottom1Title.text = "Loan Term"
        bottom1Title.font = UIFont(name: kOSRegular, size: 16.px())
        bottom1Title.textColor = UIColor.white
        return bottom1Title
    }()
    
    lazy var bottom1Desc: UILabel = {
        let bottom1Title = UILabel(frame: CGRectMake(20.px(), 50.px(), 150.px(), 22.px()))
//        bottom1Title.text = "91~240  Days"
        bottom1Title.font = UIFont(name: kOSBold, size: 20.px())
        bottom1Title.textColor = UIColor.white
        return bottom1Title
    }()
    
    
    lazy var bottom2Title: UILabel = {
        let bottom2Title = UILabel(frame: CGRectMake(180.px(), 18.px(), 150.px(), 22.px()))
//        bottom2Title.text = "Interest Rate"
        bottom2Title.font = UIFont(name: kOSRegular, size: 16.px())
        bottom2Title.textColor = UIColor.white
        return bottom2Title
    }()
    
    lazy var bottom2Desc: UILabel = {
        let bottom2Desc = UILabel(frame: CGRectMake(180.px(), 50.px(), 150.px(), 22.px()))
//        bottom2Desc.text = "22~32 %"
        bottom2Desc.font = UIFont(name: kOSBold, size: 20.px())
        bottom2Desc.textColor = UIColor.white
        return bottom2Desc
    }()
    
    
    lazy var topConImgView: UIImageView = {
        let topConImgView = UIImageView(frame: CGRectMake(23.px(), 287.px(), 331.px(), 91.px()))
        topConImgView.image = UIImage(named:"bg_limit")
        topConImgView.addSubview(self.topConImgViewTitle)
        topConImgView.addSubview(self.topConImgViewDesc)
        topConImgView.addSubview(self.imgPso)
        topConImgView.transform = CGAffineTransformMakeRotation(M_PI/180 * 4);

        topConImgView.isUserInteractionEnabled = true
        topConImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTapAction)))
        
        return topConImgView
    }()
    
    lazy var topConImgViewTitle: UILabel = {
        let bottom2Title = UILabel(frame: CGRectMake(32.px(), 19.px(), 277.px(), 22.px()))
//        bottom2Title.text = "Your borrowing limit range"
        bottom2Title.font = UIFont(name: kOSRegular, size: 16.px())
        bottom2Title.textColor = UIColor.white
        bottom2Title.textAlignment = .center
        return bottom2Title
    }()
    
    lazy var topConImgViewDesc: UILabel = {
        let topConImgViewDesc = UILabel(frame: CGRectMake(55.px(), 37.px(), 277.px(), 51.px()))
        
        topConImgViewDesc.font = UIFont(name: kOSBold, size: 37.px())
        topConImgViewDesc.textColor = UIColor.white
        topConImgViewDesc.textAlignment = .center
        return topConImgViewDesc
    }()
    
    lazy var imgPso: UIImageView = {
        let imgPso = UIImageView(frame: CGRectMake(0.px(), 0.px(), 32.px(), 29.px()))
        imgPso.image = UIImage(named:"image_peso")
        imgPso.isHidden = true;
        return imgPso
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.conScrollowView)
        
    }
    
    
    @objc func openTapAction (){
       self.selBlock!()
   }
    
    func selblockAction(block: @escaping SelRoot1ViewBlock) -> Void {
        self.selBlock = block
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
