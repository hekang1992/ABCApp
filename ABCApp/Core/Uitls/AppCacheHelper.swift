//
//  AppCacheHelper.swift
//  ABCApp
//
//  Created by Boris on 2024/1/31.
//

import UIKit

typealias SelBlock = () -> ()

    

class AppCacheHelper: NSObject {

    static let sharedInstance: AppCacheHelper = {
        let instance = AppCacheHelper()
        // setup code
        return instance
    }()
    
    var btnSelBlock: SelBlock?

    var isPostDevice = 0
    var isPostLocation = 0
    
     lazy var codeBtn:SXGCodeButton = {
        let codeBtn = SXGCodeButton.init(duration: 60) {
            self.btnSelBlock!()
        } countDownStart: {

        } countDownUnderway: { restCountDownNum in
            self.codeBtn.setTitle(NSString(format: "%ldS", restCountDownNum) as String, for: .normal)
            self.codeBtn.titleLabel?.font = UIFont(name: kOSRegular, size: 18.px());
        } countDownCompletion: {
            self.codeBtn.setTitle("Send", for: .normal)
            self.codeBtn.titleLabel?.font = UIFont(name: kOSRegular, size: 18.px());
        }

        codeBtn.setTitle("Send", for: .normal)
        codeBtn.setTitleColor(UIColor.init("#299F2D"), for: .normal)
        codeBtn.titleLabel?.font = UIFont(name: kOSRegular, size: 18.px());
        codeBtn.frame = CGRectMake(0.px(), 0.px(), 68.px(), 50.px());

        return codeBtn

        
    }()

    
//    lazy var aniView = {
        
//        // someJSONFileName 指的就是用 AE 导出的动画本地 JSON 文件名
//        let animationView = AnimationView(name: "someJSONFileName")
//
//        // 可以使用 frame 也可以使用自动布局
//        animationView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//
//        view.addSubview(animationView)
//
//        animationView.play { (isFinished) in
//
//            // 动画执行完成后的回调
//            // Do Something
//        }
//    }()
    
    func selBtnBlockAction(block: @escaping SelRoot1ViewBlock) -> Void {
        self.btnSelBlock = block
    }
    
    
}
