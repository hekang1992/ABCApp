//
//  ChooseCameraView.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit

typealias ChooseCameraViewSelBlock = () -> ()


class ChooseCameraView: UIView {
    
    var selCameraBlock: ChooseCameraViewSelBlock?
    var selPhotoBlock: ChooseCameraViewSelBlock?

    
    lazy var backImgView : UIImageView = {
        let backImgView = UIImageView(frame: CGRectMake(0, kScreenHeight - 110.px() - 231.px(), kScreenWidth, 110.px()))
        backImgView.image = UIImage(named: "bg_idconfirm")
        backImgView.isUserInteractionEnabled = true
        
        return backImgView
    }()
    
    lazy var conView : UIView = {
        let backImgView = UIView(frame: CGRectMake(0, kScreenHeight - 231.px(), kScreenWidth, 231.px()))
        
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = backImgView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        backImgView.layer.addSublayer(bgLayer1)
        
  
        
        backImgView.addSubview(self.cameraBtn)
        backImgView.addSubview(self.photoBtn)
        
        return backImgView
    }()
    
 
    lazy var closeBtn : UIButton = {
        
        let closeBtn = UIButton.init(frame: CGRectMake(kScreenWidth - 52.px(), CGRectGetMinY(self.backImgView.frame) - 35.px(), 35.px(), 35.px()))
        closeBtn.setImage(UIImage(named: "Loginicon_signin_cancel"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeBtn
        
    }()
    
   
    lazy var cameraBtn: UIButton = {
        
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.frame = CGRectMake(17.px(), 61.px(), 341.px(), 50.px())
        cameraBtn.layer.masksToBounds = true
        cameraBtn.layer.cornerRadius = 15.px()
        
        cameraBtn.backgroundColor = UIColor.white
        cameraBtn.setTitle("Camera", for: .normal)
        cameraBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        cameraBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        
        cameraBtn.addTarget(self, action: #selector(cameraBtnAction), for: .touchUpInside)
        
        return cameraBtn
    }()
    
    lazy var photoBtn:UIButton = {
        let photoBtn = UIButton(type: .custom)
        photoBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(cameraBtn.frame) + 30.px(), 341.px(), 50.px())
        photoBtn.layer.masksToBounds = true
        photoBtn.layer.cornerRadius = 15.px()
        
        photoBtn.backgroundColor = UIColor.white
        photoBtn.setTitle("Photo Album", for: .normal)
        photoBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        photoBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        
        photoBtn.addTarget(self, action: #selector(photoBtnAction), for: .touchUpInside)
        
        return photoBtn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString:"#333333", alpha:0.6)
        self.addSubview(self.backImgView)
        self.addSubview(self.conView)
        self.addSubview(self.closeBtn)
                
    }
    

    @objc func closeAction(){
        self.removeFromSuperview()
    }
    
    @objc func cameraBtnAction(){
        self.selCameraBlock!()
        self.removeFromSuperview()
    }
    func selCameraBlockAction(block: @escaping ChooseCameraViewSelBlock) -> Void {
        self.selCameraBlock = block
    }
    
    
    @objc func photoBtnAction(){
        self.selPhotoBlock!()
        self.removeFromSuperview()
    }
    func selPhotoBlockAction(block: @escaping ChooseCameraViewSelBlock) -> Void {
        self.selPhotoBlock = block
        self.removeFromSuperview()

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
