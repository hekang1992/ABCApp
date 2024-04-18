//
//  IDVerificationVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/25.
//

import UIKit
import AVFoundation
import HandyJSON
import Kingfisher

class IDVerificationVC: BaseVC, UIImagePickerControllerDelegate {

    var imageSource = "";
    
    var idTypeStr = "";
    var productId:String = "";
    var orderStr: String = "";
    var chooseSelType: String = "";
    var idInfoModle: InfomationModel?
    var faceConModle: FaceModel?
    
    var IdCardStartTime: String?
    var faceStartTime:String?
    
    lazy var imgPickerVC:UIImagePickerController? = nil
    

    lazy var conScrollowView : UIScrollView = {
        
        let conScrollowView = UIScrollView(frame: CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight))
        conScrollowView.contentSize = CGSize(width: kScreenWidth, height: 588.px() + 136.px())
        conScrollowView.showsVerticalScrollIndicator = false
        
        let topImgView = UIImageView(image: UIImage(named: "bg_yanzheng"))
        topImgView.frame = CGRectMake(0, 0, kScreenWidth, 136.px())
        conScrollowView.addSubview(topImgView)
        conScrollowView .addSubview(self.scrollowBackView)
        conScrollowView.backgroundColor = UIColor.clear
        return conScrollowView
    }()
    
    lazy var scrollowBackView : UIView = {
        
        let scrollowBackView = UIView(frame: CGRectMake(0, 136.px(), kScreenWidth, 588.px()))
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = scrollowBackView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        scrollowBackView.layer.addSublayer(bgLayer1)
        
        
        let bg_step1 = UIImageView(image: UIImage(named: "idverifyStep"))
        bg_step1.frame = CGRectMake(78.px(), -67.px(), 106.px(), 264.px())
        scrollowBackView.addSubview(bg_step1)
        
        scrollowBackView.addSubview(step1View)
        scrollowBackView.addSubview(step2View)
        
        scrollowBackView.addSubview(chooseTypeBtn)
        scrollowBackView.addSubview(confirmBtn)
        
        return scrollowBackView
    }()
    
    lazy var step1View:UIView = {
        
        let step1View = UIView(frame: CGRectMake(48.px(), 0.px(), 280.px(), 165.px()))
        step1View.backgroundColor = UIColor.init("#FFF4CC")
        step1View.layer.masksToBounds = true
        step1View.layer.cornerRadius = 15.px()
        
        step1View.transform = CGAffineTransformMakeRotation(M_PI/180 * 2);
        
        let step1Label = UILabel(frame: CGRectMake(10.px(), 17.px(), 250.px(), 22.px()))
        step1Label.text = "Please upload the selected ID card"
        step1Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step1Label.textColor = UIColor.init("#299F2D")
        step1View.addSubview(step1Label)
        
        step1View.addSubview(idCardView)
        
        let iconCamera = UIImageView(image: UIImage(named: "idVerifiicon_camera"))
        iconCamera.frame = CGRectMake(213.px(), 75.px(), 46.px(), 42.px())
        iconCamera.isUserInteractionEnabled = true
        iconCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takeIdCardAction)))
        step1View.addSubview(iconCamera)
        
        return step1View
    }()
    
    lazy var idCardView:UIImageView = {
        
        let idCardView = UIImageView(image: UIImage(named: "image_idcard"))
        idCardView.frame = CGRectMake(15.px(), 45.px(), 175.px(), 105.px())
        idCardView.contentMode = .scaleAspectFill
        idCardView.clipsToBounds = true
        idCardView.layer.masksToBounds = true
        idCardView.layer.cornerRadius = 10.px()
        return idCardView
    }()
    
    lazy var step2View:UIView = {
        
        let step2View = UIView(frame: CGRectMake(48.px(), CGRectGetMaxY(self.step1View.frame) + 40.px(), 280.px(), 165.px()))
        step2View.backgroundColor = UIColor.init("#FFF4CC")
        step2View.layer.masksToBounds = true
        step2View.layer.cornerRadius = 15.px()
        
        let step1Label = UILabel(frame: CGRectMake(10.px(), 10.px(), 250.px(), 50.px()))
        step1Label.text = "Please scan your face to complete the verification"
        step1Label.numberOfLines = 0
        step1Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step1Label.textColor = UIColor.init("#299F2D")
        step2View.addSubview(step1Label)
        
        step2View.addSubview(faceCardView)
        step2View.addSubview(lineView)
        
        let iconCamera = UIImageView(image: UIImage(named: "idVerifiicon_faceid"))
        iconCamera.frame = CGRectMake(213.px(), 89.px(), 46.px(), 42.px())
        step2View.addSubview(iconCamera)
        iconCamera.isUserInteractionEnabled = true
        iconCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takeFaceAction)))
        
        return step2View
    }()
    
    lazy var faceCardView:UIImageView = {
        
        let faceCardView = UIImageView()
        faceCardView.frame = CGRectMake(17.px(), 69.px(), 175.px(), 81.px())
        faceCardView.contentMode = .scaleAspectFill
        faceCardView.clipsToBounds = true
        faceCardView.layer.masksToBounds = true
        faceCardView.layer.cornerRadius = 10.px()
        return faceCardView
    }()
    
    lazy var lineView: UIView = {
        
        let conView = DeviceInfoManager.getLineJoinRoundView(frame: CGRectMake(17.px(), 69.px(), 175.px(), 81.px()), cornerRadius: 10.px(), borderColor: UIColor.init("#DDAE02"), borderWidth: 1.px())
        conView.backgroundColor = UIColor.init("#FFFAE7")
  
        
        let step1Label = UILabel(frame: CGRectMake(30.px(), 7.px(), 150.px(), 22.px()))
        step1Label.text = "Good lighting"
        step1Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step1Label.textColor = UIColor.init("#DDAE02")
        conView.addSubview(step1Label)
        
        
        let point1View = UIView(frame: CGRectMake(17.px(), CGRectGetMidY(step1Label.frame) - 2.px(), 4.px(), 4.px()))
        point1View.layer.cornerRadius = 2.px();
        point1View.layer.masksToBounds = true;
        point1View.backgroundColor = UIColor.init("#DDAE02")
        conView.addSubview(point1View)
        
        let step2Label = UILabel(frame: CGRectMake(30.px(), CGRectGetMaxY(step1Label.frame) + 0.px(), 150.px(), 22.px()))
        step2Label.text = "Clear environment"
        step2Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step2Label.textColor = UIColor.init("#DDAE02")
        conView.addSubview(step2Label)
        
        
        let point2View = UIView(frame: CGRectMake(17.px(), CGRectGetMidY(step2Label.frame) - 2.px(), 4.px(), 4.px()))
        point2View.layer.cornerRadius = 2.px();
        point2View.layer.masksToBounds = true;
        point2View.backgroundColor = UIColor.init("#DDAE02")
        conView.addSubview(point2View)
        
        let step3Label = UILabel(frame: CGRectMake(30.px(), CGRectGetMaxY(step2Label.frame) , 150.px(), 22.px()))
        step3Label.text = "Natural expression"
        step3Label.font =  UIFont(name: kOSRegular, size: 16.px())
        step3Label.textColor = UIColor.init("#DDAE02")
        conView.addSubview(step3Label)
        
        
        let point3View = UIView(frame: CGRectMake(17.px(), CGRectGetMidY(step3Label.frame) - 2.px(), 4.px(), 4.px()))
        point3View.layer.cornerRadius = 2.px();
        point3View.layer.masksToBounds = true;
        point3View.backgroundColor = UIColor.init("#DDAE02")
        conView.addSubview(point3View)
        
        
        return conView
        
    }()
    
    lazy var chooseTypeBtn:UIButton = {
        let chooseBtn = UIButton(type: .custom)
        chooseBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(step2View.frame) + 51.px(), 341.px(), 50.px())
        chooseBtn.layer.masksToBounds = true
        chooseBtn.layer.cornerRadius = 15.px()
        
        chooseBtn.backgroundColor = UIColor.white
        chooseBtn.setTitle("Modify ID Type", for: .normal)
        chooseBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        chooseBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        chooseBtn.addTarget(self, action: #selector(chooseIdTypeAction), for: .touchUpInside)
        return chooseBtn
    }()
    
    lazy var confirmBtn:UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRectMake(17.px(), CGRectGetMaxY(chooseTypeBtn.frame) + 30.px(), 341.px(), 50.px())
        confirmBtn.layer.masksToBounds = true
        confirmBtn.layer.cornerRadius = 15.px()
        
        confirmBtn.backgroundColor = UIColor.init("#299F2D")
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        
        return confirmBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 290.px()))
        bgView.backgroundColor = UIColor.init("#FFF2E0")
        self.view.addSubview(bgView)
        
        self.view.addSubview(self.conScrollowView)
        
        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "ID Verification"
            
        let paramsDic = ["campaign":self.productId,
                         "possibly":AppClassUtilsHelper.getRandomeStrAction(count: 12)]
        
        
        AppNetHelper.get_thickContainment(params: paramsDic) { succ in
            
            
            let conDic = succ.mcneil as! [String:Any]
            self.idInfoModle = JSONDeserializer<InfomationModel>.deserializeFrom(dict: conDic)

            if (self.idInfoModle?.names?.pause == "1") {
                self.idCardView.kf.setImage(with: URL(string: self.idInfoModle?.names?.giving ?? ""))
                self.step1View.isUserInteractionEnabled = false;
            }
            
            
            if (self.idInfoModle?.jealous == "1") {
                // 人脸完成
                self.lineView.isHidden = true;
                self.faceCardView.kf.setImage(with: URL(string: self.idInfoModle?.giving ?? ""))
                self.step2View.isUserInteractionEnabled = false;
            }
            
            if ((self.idInfoModle?.names?.promoted.count ?? 0) > 0){
                
                self.chooseTypeBtn.setTitle(self.idInfoModle?.names?.promoted, for: .normal)
                self.chooseTypeBtn.isUserInteractionEnabled = false
                
            }
            
            
            
        } fail: { fail in
            
        }


        // Do any additional setup after loading the view.
    }
    
    @objc func chooseIdTypeAction (){
        
        self.navigationController?.popViewController(animated: true)
//        let chooseTypeVC = IDCardTypeVC()
//        chooseTypeVC.sourceArr = self.idInfoModle?.regretting
//        chooseTypeVC.conTableView.reloadData()
//        chooseTypeVC.selTypeBlockAction { typeStr in
//            self.idTypeStr = typeStr;
//            self.chooseTypeBtn.setTitle(typeStr, for: .normal)
//        }
//        self.navigationController?.pushViewController(chooseTypeVC, animated: true)
        
    }
    
    @objc func takeIdCardAction(){
        
        if(self.idTypeStr.count == 0){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please Choose the ID Card Type")
            return
        }
        
        self.chooseSelType = "IDCard"
        self.getImgPicAction()
    }
    
    @objc func takeFaceAction(){
        
        if (self.idInfoModle?.names?.pause != "1"){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please upload the selected ID card first.")
            return
        }
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)

        if authStatus == .denied || authStatus == .restricted {
            let alertController = UIAlertController(title: "", message: "Please go to Settings-App-Camera to open authorization settings.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Sure", style: .default) { action in
                // 无权限，引导去开启
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }else if authStatus == .notDetermined{
            AVCaptureDevice.requestAccess(for: .video) { isSuccess in
                
                DispatchQueue.main.async {
                    if isSuccess {
                        self.takeFaceAction()
                        
                    }else{
                        
                        let alertController = UIAlertController(title: "", message: "Please go to Settings-App-Camera to open authorization settings.", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "Sure", style: .default) { action in
                            // 无权限，引导去开启
                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.openURL(url)
                            }
                        }
                        alertController.addAction(confirmAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
                
              
            }
            return

        }
        
        self.chooseSelType = "Face"
//        self.getImgPicAction()
        self.faceStartTime = DeviceInfoManager.getCurrentMillis()

        let postParams = ["prefers":AppClassUtilsHelper.getRandomeStrAction(count: 10), "sayin":AppClassUtilsHelper.getRandomeStrAction(count: 10)]
        
        AppNetHelper.post_workedSkyscrapersAction(params: postParams) { succ in
            
            let conDic = succ.mcneil as! [String:Any]
            let faceConModle = JSONDeserializer<FaceModel>.deserializeFrom(dict: conDic)!
            
            let checkResult = AAILivenessSDK.configLicenseAndCheck(faceConModle.faked!)
            if (checkResult == "SUCCESS"){
                let vc = AAILivenessViewController()
                
                vc.detectionSuccessBlk = { rawVC, result in
                    let livenessId = result.livenessId
                    
                       // Get eventId (You should save this ID in case of tracking problems).
                       //let eventId = result.eventId
                    let eventId = result.livenessId

                       // The best quality face image captured by the SDK. Note that the default image size is 600x600.
                       let bestImg = result.img
                       let size = bestImg.size
                       print(">>>>>livenessId: \(livenessId), imgSize: \(size.width), \(size.height)")

                       // A small square image containing only the face area, image size is 300x300.
                       let fullFaceImg = result.fullFaceImg
                    
                    rawVC.navigationController?.popViewController(animated: true)
                    
                    
                    let params:[String:String] = [
//                        "leaves":self.imageSource,
                        "campaign":self.productId,
                        "wrinkles":"10",
                        "wrencher":livenessId,
                        "carrying":AppClassUtilsHelper.getRandomeStrAction(count: 12),
                        "johnboy":faceConModle.johnboy!,
                        "promoted":self.idTypeStr
                    ]
                    AppNetHelper.post_helmetHoweverAction(params: params, img: fullFaceImg) { succ in
                        self.lineView.isHidden = true;
                        self.faceCardView.image = fullFaceImg
                        self.step2View.isUserInteractionEnabled = false;
                        self.idInfoModle?.jealous = "1"
                    } fail: { fail in
                        
                    }

                    let endTime:String = DeviceInfoManager.getCurrentMillis();

                    let postParams:[String:String] = [
                        "judicial": self.productId,   // 产品ID
                        "triangle": "4",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                        "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                        "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                        "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                        "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                        "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                        "practiced": self.faceStartTime! , // 开始时间
                        "quicker": endTime ,   // 结束时间
                        "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
                    ]
                    print("aaa  -- 上报 face信息 \(postParams)")

                    AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                        print("aaa  -- 上报 face信息 成功")

                    } fail: { fail in
                        print("aaa  -- 上报 face信息 失败")

                    }

                    
                
                
                    
                    
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
      

            }
            
            
         
            print("")
            
        } fail: { fail in
            
        }


    }
    
    
    func getImgPicAction(){
                
        
        self.IdCardStartTime = DeviceInfoManager.getCurrentMillis()
        
        let chooseCameraView:ChooseCameraView = ChooseCameraView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        chooseCameraView.selPhotoBlockAction {
            self.imageSource = "1"
            self.imgPickerVC = UIImagePickerController()
            self.imgPickerVC?.delegate = self
            self.imgPickerVC?.allowsEditing = false
            self.imgPickerVC?.sourceType = .photoLibrary
            self.present(self.imgPickerVC!, animated: true)
        }
        chooseCameraView.selCameraBlockAction {
            
            self.imageSource = "2"
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)

            if authStatus == .denied || authStatus == .restricted {
                let alertController = UIAlertController(title: "", message: "Please go to Settings-App-Camera to open authorization settings.", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "Sure", style: .default) { action in
                    // 无权限，引导去开启
                    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    }
                }
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }else if authStatus == .notDetermined{
                AVCaptureDevice.requestAccess(for: .video) { isSuccess in
                    
                    DispatchQueue.main.async {
                        if isSuccess {
                            self.imgPickerVC = UIImagePickerController()
                            self.imgPickerVC?.delegate = self
                            self.imgPickerVC?.allowsEditing = false
                            self.imgPickerVC?.sourceType = .camera
                            self.imgPickerVC?.cameraDevice = .rear
                            self.present(self.imgPickerVC!, animated: true)
                        }else{
                            
                            let alertController = UIAlertController(title: "", message: "Please go to Settings-App-Camera to open authorization settings.", preferredStyle: .alert)
                            
                            let confirmAction = UIAlertAction(title: "Sure", style: .default) { action in
                                // 无权限，引导去开启
                                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                            alertController.addAction(confirmAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                    }
                    
                  
                }
                return

            }
                
                
            
                self.imgPickerVC = UIImagePickerController()
                self.imgPickerVC?.delegate = self
                self.imgPickerVC?.allowsEditing = false
                self.imgPickerVC?.sourceType = .camera
                self.imgPickerVC?.cameraDevice = .rear
                self.present(self.imgPickerVC!, animated: true)
            
            
           
        }
        self.view.addSubview(chooseCameraView)

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 在这里使用获取到的图像
            
            
            if (self.chooseSelType == "Face"){

                
                let params = [
                    "leaves":self.imageSource,
                    "campaign":self.productId,
                    "wrinkles":"10",
                    "wrencher":"",
                    "carrying":AppClassUtilsHelper.getRandomeStrAction(count: 12),
                    "johnboy":"1",
                    "promoted":self.idTypeStr
                ]
                AppNetHelper.post_helmetHoweverAction(params: params, img: image) { succ in
    
                    self.faceCardView.image = image
                    self.lineView.isHidden = true
                    
                } fail: { fail in
    
                }
                
            }else{
                let params = [
                    "leaves":self.imageSource,
                    "campaign":self.productId,
                    "wrinkles":"11",
                    "wrencher":"",
                    "carrying":AppClassUtilsHelper.getRandomeStrAction(count: 12),
                    "johnboy":"1",
                    "promoted":self.idTypeStr
                ]
                AppNetHelper.post_helmetHoweverAction(params: params, img: image) { succ in
                    
                    let conDic = succ.mcneil as! [String:Any]
                    let infoUserModel = JSONDeserializer<InfomationModel>.deserializeFrom(dict: conDic)
                    
                    let infoConfirmView:VerifyIDInfoView = VerifyIDInfoView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
                    
                    infoConfirmView.tit1Label.text = "\(self.idTypeStr) Name"
                    infoConfirmView.tit2Label.text = "\(self.idTypeStr) Number"
                    infoConfirmView.tit3Label.text = "\(self.idTypeStr) Date"
                    
                    infoConfirmView.con1TF.text = infoUserModel?.formed
                    infoConfirmView.con2TF.text = infoUserModel?.weight
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    let selDate = dateFormatter.date(from: infoUserModel?.shifted ?? "") ?? Date()
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "dd/MM/yyyy"
                    let showDate = dateFormatter1.string(from: selDate)
                    
                    infoConfirmView.con3Label.text = showDate
                    
                    infoConfirmView.confirmBlockAction { name, number, dateStr in
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy"
                        let selDate = dateFormatter.date(from: dateStr) ?? Date()
                        
                     
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "yyyy/MM/dd"
                        let showDate = dateFormatter1.string(from: selDate)
                        

                        let params = [
                            "campaign":self.productId,
                            "wrinkles":"11",
                            "promoted":self.idTypeStr,
                            "shifted":showDate,
                            "weight":number,
                            "formed":name
                        ]
                        
                         AppNetHelper.post_theresLevelAction(params: params) { succ in
                            
                            self.step1View.isUserInteractionEnabled = false
                            self.chooseTypeBtn.isUserInteractionEnabled = false
                            self.idInfoModle?.names?.pause = "1"
                            infoConfirmView.removeFromSuperview()
                            
                             self.idCardView.image = image
                             
                             let endTime:String = DeviceInfoManager.getCurrentMillis();

                             let postParams:[String:String] = [
                                "judicial": self.productId,   // 产品ID
                                 "triangle": "3",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                                 "toying": self.orderStr,  // 用户申贷全局订单号，不用管
                                 "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                                 "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                                 "smaller": String(LocationManager.sharedInstance.currentLcoation?.coordinate.latitude ?? 0),//维度
                                 "today": String(LocationManager.sharedInstance.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                                 "practiced": self.IdCardStartTime! , // 开始时间
                                 "quicker": endTime ,   // 结束时间
                                 "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
                             ]
                             print("aaa  -- 上报 证件信息 \(postParams)")

                             AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                                 print("aaa  -- 上报 证件信息 成功")

                             } fail: { fail in
                                 print("aaa  -- 上报 证件信息 失败")

                             }

                             
                        } fail: { fail in
                            
                        }
                        
                        
                        
                    }

                    self.view.addSubview(infoConfirmView)
                    
                } fail: { fail in
    
                }
                
            }
        }
    }
    
    @objc func confirmBtnAction(){
        
        if (self.idInfoModle?.names?.pause != "1"){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please upload the selected ID card.")
            return
        }
        
        if (self.idInfoModle?.jealous != "1"){
            AppClassUtilsHelper.makeTopHudidAction(str: "Please scan your face to complete the verification.")
            return
        }
        
 
        
        
        if (self.idInfoModle?.names?.pause == "1" && self.idInfoModle?.jealous == "1") {
        
            let paramsDic = [
                "campaign":self.productId,
                "wavered":AppClassUtilsHelper.getRandomeStrAction(count: 3),
                "fortieth":AppClassUtilsHelper.getRandomeStrAction(count: 6)
                
            ]
            
            AppNetHelper.post_weveAreAction(params: paramsDic) { succ in

                let conDic = succ.mcneil as! [String:Any]
                let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                
                if (detailModel?.honestly?.decide == "33" || detailModel?.honestly?.decide == "44" || detailModel?.honestly?.decide == "55" || detailModel?.honestly?.decide == "66" || detailModel?.honestly?.decide == "77"){
                    
                    AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: self.productId, order: detailModel?.concern?.toying ?? "")
                    
                }else{
                    
                }
                
                
            } fail: { fail in
                
            }
            
        }
        
    }
    
    @objc override func backClick() {
        
        let alert = UIAlertController(title: "Are you sure you want to leave?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel) { action in
            for vc in self.navigationController!.children {
                if let borrowingVC = vc as? AuthenticationVC {
                    self.navigationController?.popToViewController(borrowingVC, animated: true)
                    return
                }
            }
            self.navigationController?.popViewController(animated: true)

        }
        alert.addAction(cancelAction)
        let doneAction = UIAlertAction(title: "Give Up", style: .destructive) { action in
            // Handle continue action if needed
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


