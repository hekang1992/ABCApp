//
//  AlertNextViewController.swift
//  ABCApp
//
//  Created by apple on 2024/4/1.
//

import UIKit
import AVFoundation
import HandyJSON

class AlertNextViewController: BaseVC, UIImagePickerControllerDelegate {
    
    var productId:String = ""
    var type: String = ""
    var imageUrl: String = ""
    var isUploadFace: Bool = false
    
    lazy var conScrollowView : UIScrollView = {
        let conScrollowView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        conScrollowView.contentSize = CGSize(width: kScreenWidth, height: 828.px() + 136.px())
        conScrollowView.showsVerticalScrollIndicator = false
        let topImgView = UIImageView(image: UIImage(named: "bg_yanzheng"))
        topImgView.frame = CGRectMake(0, 0, kScreenWidth, 136.px())
        conScrollowView.addSubview(topImgView)
        conScrollowView .addSubview(self.scrollowBackView)
        conScrollowView.backgroundColor = UIColor.clear
        return conScrollowView
    }()
    
    lazy var scrollowBackView : UIView = {
        let scrollowBackView = UIView(frame: CGRectMake(0, 136.px(), kScreenWidth, 828.px() + 136.px()))
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.91, blue: 0.58, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = scrollowBackView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        scrollowBackView.layer.addSublayer(bgLayer1)
        return scrollowBackView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Slicefdas")
        return icon
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "idcardas")
        icon1.layer.cornerRadius = 15.px()
        icon1.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        icon1.addGestureRecognizer(tapGesture)
        return icon1
    }()
    
    lazy var nextView1: AlertNextView = {
        let nextView1 = AlertNextView()
        nextView1.nameLabel.text = "Name"
        nextView1.iconImageView.image = UIImage(named: "icon_inputfad")
        nextView1.textF.placeholder = "Name"
        return nextView1
    }()
    
    lazy var nextView2: AlertNextView = {
        let nextView1 = AlertNextView()
        nextView1.nameLabel.text = "Gender"
        nextView1.iconImageView.image = UIImage(named: "icon_selefdas")
        nextView1.textF.placeholder = "Gender"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:)))
        nextView1.textF.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        return nextView1
    }()
    
    lazy var nextView3: AlertNextView = {
        let nextView1 = AlertNextView()
        nextView1.nameLabel.text = "ID Number"
        nextView1.iconImageView.image = UIImage(named: "icon_inputfad")
        nextView1.textF.placeholder = "ID Number"
        return nextView1
    }()
    
    lazy var nextView4: AlertNextView = {
        let nextView1 = AlertNextView()
        nextView1.nameLabel.text = "Loan Purpose"
        nextView1.iconImageView.image = UIImage(named: "icon_selefdas")
        nextView1.textF.placeholder = "Loan Purpose"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:)))
        nextView1.textF.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        return nextView1
    }()
    
    lazy var nextView5: AlertNextView = {
        let nextView1 = AlertNextView()
        nextView1.nameLabel.text = "Email"
        nextView1.iconImageView.image = UIImage(named: "icon_inputfad")
        nextView1.textF.placeholder = "Email"
        return nextView1
    }()
    
    lazy var conFirmBtn: UIButton = {
        let conFirmBtn = UIButton(type: .custom)
        conFirmBtn.setTitle("Confirm", for: .normal)
        conFirmBtn.setTitleColor(.white, for: .normal)
        conFirmBtn.titleLabel?.font = UIFont(name: kOSBold, size: 24.px())
        conFirmBtn.backgroundColor = UIColor.init("#299F2D")
        conFirmBtn.layer.cornerRadius = 15.px()
        conFirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
        return conFirmBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(conScrollowView)
        self.addBackBtnAction()
        self.addTitleLabelAction()
        self.titlelabel.text = "Face ID & Personal Info"
        scrollowBackView.addSubview(icon)
        scrollowBackView.addSubview(icon1)
        scrollowBackView.addSubview(nextView1)
        scrollowBackView.addSubview(nextView2)
        scrollowBackView.addSubview(nextView3)
        scrollowBackView.addSubview(nextView4)
        scrollowBackView.addSubview(nextView5)
        scrollowBackView.addSubview(conFirmBtn)
        icon.snp.makeConstraints { make in
            make.left.equalTo(scrollowBackView).offset(65.px())
            make.top.equalTo(scrollowBackView).offset(-60.px())
            make.size.equalTo(CGSizeMake(120.px(), 260.px()))
        }
        icon1.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.size.equalTo(CGSizeMake(280.px(), 165.px()))
            make.top.equalTo(icon.snp.top).offset(67.px())
            make.left.equalTo(scrollowBackView).offset(48.px())
        }
        nextView1.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.top.equalTo(icon1.snp.bottom).offset(25.px())
            make.height.equalTo(80.px())
            make.left.equalTo(scrollowBackView)
        }
        nextView2.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.top.equalTo(nextView1.snp.bottom).offset(20.px())
            make.height.equalTo(80.px())
            make.left.equalTo(scrollowBackView)
        }
        nextView3.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.top.equalTo(nextView2.snp.bottom).offset(20.px())
            make.height.equalTo(80.px())
            make.left.equalTo(scrollowBackView)
        }
        nextView4.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.top.equalTo(nextView3.snp.bottom).offset(20.px())
            make.height.equalTo(80.px())
            make.left.equalTo(scrollowBackView)
        }
        nextView5.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.top.equalTo(nextView4.snp.bottom).offset(20.px())
            make.height.equalTo(80.px())
            make.left.equalTo(scrollowBackView)
        }
        conFirmBtn.snp.makeConstraints { make in
            make.centerX.equalTo(scrollowBackView)
            make.left.equalTo(scrollowBackView).offset(19.px())
            make.height.equalTo(50.px())
            make.top.equalTo(nextView5.snp.bottom).offset(50.px())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFaceInfo()
        getPinFo()
    }
    
    func getPinFo() {
        let params: [String: String] = [:]
        AppNetHelper.post_getPiafdaion(params: params) { [weak self] succ in
            let conDic = succ.mcneil as! [String:Any]
            let productModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            let pesonModel = productModel?.personal
            self?.nextView1.textF.text = pesonModel?.str1
            self?.nextView2.textF.text = pesonModel?.str2
            self?.nextView3.textF.text = pesonModel?.str3
            self?.nextView4.textF.text = pesonModel?.str4
            self?.nextView5.textF.text = pesonModel?.str5
        } fail: { fail in
            
        }
    }
    
    func getFaceInfo() {
        let params:[String: String] = [:]
        AppNetHelper.post_getFaceAction(params: params) { succ in
            let conDic = succ.mcneil as! [String:Any]
            let productModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            let iamgeStr: String = productModel?.audit_face ?? ""
            let imageUrl = URL(string: productModel?.audit_face ?? "")
            if iamgeStr.isEmpty {
                self.icon1.isUserInteractionEnabled = true
            }else {
                self.isUploadFace = true
                self.icon1.isUserInteractionEnabled = false
            }
            self.imageUrl = productModel?.audit_face ?? ""
            self.icon1.kf.setImage(with: imageUrl, placeholder: UIImage(named: "idcardas"))
        } fail: { fail in
            
        }
    }
    
    @objc override func backClick() {
        let alert = UIAlertController(title: "Are you sure you want to leave?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        let doneAction = UIAlertAction(title: "Give Up", style: .destructive) { action in
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        selectImge()
    }
    
    @objc func textFieldTapped(_ sender: UITapGestureRecognizer){
        guard let textField = sender.view as? UITextField else { return }
        if textField == self.nextView2.textF {
            selcefa()
        }else{
            selcefa1()
        }
    }
    
    func selcefa() {
        let alertController = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .actionSheet)
        let maleAction = UIAlertAction(title: "Male", style: .default) { (action) in
            self.nextView2.textF.text = "Male"
        }
        alertController.addAction(maleAction)
        let femaleAction = UIAlertAction(title: "Female", style: .default) { (action) in
            self.nextView2.textF.text = "Female"
        }
        alertController.addAction(femaleAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func selcefa1() {
        let alertController = UIAlertController(title: "Select Loan Purpose", message: nil, preferredStyle: .actionSheet)
        let educationAction = UIAlertAction(title: "Education", style: .default) { (action) in
            self.nextView4.textF.text = "Education"
            print("You selected Education loan purpose")
        }
        alertController.addAction(educationAction)
        
        let medicalAction = UIAlertAction(title: "Medical", style: .default) { (action) in
            self.nextView4.textF.text = "Medical"
            print("You selected Medical loan purpose")
        }
        alertController.addAction(medicalAction)
        
        let businessAction = UIAlertAction(title: "Business", style: .default) { (action) in
            self.nextView4.textF.text = "Business"
            print("You selected Business loan purpose")
        }
        alertController.addAction(businessAction)
        let homeAction = UIAlertAction(title: "Home", style: .default) { (action) in
            self.nextView4.textF.text = "Home"
            print("You selected Home loan purpose")
        }
        alertController.addAction(homeAction)
        let personalAction = UIAlertAction(title: "Personal", style: .default) { (action) in
            self.nextView4.textF.text = "Personal"
            print("You selected Personal loan purpose")
        }
        alertController.addAction(personalAction)
        let carAction = UIAlertAction(title: "Car", style: .default) { (action) in
            self.nextView4.textF.text = "Car"
            print("You selected Car loan purpose")
        }
        alertController.addAction(carAction)
        let othAction = UIAlertAction(title: "Other", style: .default) { (action) in
            self.nextView4.textF.text = "Other"
            print("You selected Car loan purpose")
        }
        alertController.addAction(othAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func selectImge() {
        // Create a UIAlertController
        let alertController = UIAlertController(title: "Select Action", message: nil, preferredStyle: .actionSheet)
        
        // Add the camera option
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            // Handle selection of camera action
            self.openCamera()
        }
        alertController.addAction(cameraAction)
        
        // Add the cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the UIAlertController
        present(alertController, animated: true, completion: nil)
    }
    
    func openCamera() {
        // Write your code to open the camera here
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
        }else if authStatus == .authorized {
            self.takeFaceAction()
        }
    }
    
    func takeFaceAction() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front // 设置为前置摄像头
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        dismiss(animated: true, completion: nil)
        
        let params:[String: String] = [:]
        AppNetHelper.post_imageAction(params: params, img: image) { [weak self] succ in
            self?.icon1.image = image
            self?.icon1.isUserInteractionEnabled = false
            self?.isUploadFace = true
        } fail: { fail in
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmClick() {
        if self.isUploadFace == false {
            AppClassUtilsHelper.makeTopHudidAction(str: "Please upload your facial information")
            return
        }
        let str1: String = self.nextView1.textF.text ?? ""
        let str2: String = self.nextView2.textF.text ?? ""
        let str3: String = self.nextView3.textF.text ?? ""
        let str4: String = self.nextView4.textF.text ?? ""
        let str5: String = self.nextView5.textF.text ?? ""
        let isEmail = isValidEmail(str5)
        if (str1.isEmpty || str2.isEmpty || str3.isEmpty || str4.isEmpty) {
            AppClassUtilsHelper.makeTopHudidAction(str: "Please fill in your information.")
            return
        }
        if !isEmail {
            AppClassUtilsHelper.makeTopHudidAction(str: "Invalid email format")
            return
        }
        let params: [String:String] = ["str1":str1,"str2":str2,"str3":str3,"str4":str4,"str5":str5]
        AppNetHelper.post_getPinction(params: params) { succ in
            let conDic = succ.mcneil as! [String:Any]
            let productModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
            let paramsDic = ["campaign":"2"]
            AppNetHelper.post_weveAreAction(params: paramsDic) { succ in
                let conDic = succ.mcneil as! [String:Any]
                let detailModel = JSONDeserializer<ProductModel>.deserializeFrom(dict: conDic)
                if (detailModel?.honestly?.decide == "33" || detailModel?.honestly?.decide == "44" || detailModel?.honestly?.decide == "55" || detailModel?.honestly?.decide == "66" || detailModel?.honestly?.decide == "77"){
                    AppLaunchUtils.pushVerifyVCAction(rootVC: self, route: detailModel?.honestly?.decide ?? "", productId: self.productId, order: detailModel?.concern?.toying ?? "")
                }else{
                }
            } fail: { fail in
                
            }
        } fail: { fail in
            
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

