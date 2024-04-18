//
//  AppHelper.swift
//  ABCApp
//
//  Created by Boris on 2024/2/21.
//

import UIKit
import SVProgressHUD

class AppHelper: NSObject {

    static var loadingCount = 0
    
   class func getStrWidth(str: String, height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = str.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    
    class func getStrHeight(str: String, width: CGFloat, font: UIFont) -> CGFloat {

        
        let constraintSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
           let boundingBox = str.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
           return boundingBox.height
        
     }
    
    
    // 防抖
    static var searchWorkItem: DispatchWorkItem = DispatchWorkItem {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            loadingCount = 0
            SVProgressHUD.dismiss()
        }
    }


    class func showLoading() {
        loadingCount += 1
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        
        searchWorkItem.cancel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: searchWorkItem)
        
    }

    /// 隐藏loading
    class func hid() {
//        loadingCount -= 1
//        if loadingCount > 0{
//            return
//        }else{
//            loadingCount = 0
//        }
        
        loadingCount -= 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            if (loadingCount > 0){
                
            }else{
                loadingCount = 0
                
                searchWorkItem.cancel()

                
                if OperationQueue.current == OperationQueue.main {
                     SVProgressHUD.dismiss()
                }else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                }
            }
            
        }
        
        
      
    }
}
