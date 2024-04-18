//
//  AppClassUtilsHelper.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit
import AdSupport
import CoreFoundation
class AppClassUtilsHelper: NSObject {
    
    // 判断是否是刘海屏
    @objc class func isNotchPhoneScreenAction () -> Bool{
      var result : Bool = false
      if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        result = false
      }
      if #available(iOS 11, *) {

          if UIApplication.shared.windows.count > 0 {
              let w = UIApplication.shared.windows[0].safeAreaInsets.bottom

              if w > 0 {
                result = true
              }else{
                result = false
              }
          }else{
              result = false
          }

      }else{
        result = false
      }
      return result;
    }
    
    
    
    // userdefault 操作
    @objc class public func saveUserDefault (value:Any, key:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    @objc class public func getUserDefault (key:String) -> Any? {
         return UserDefaults.standard.object(forKey: key)
    }
    @objc class public func delUserDefault (key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    @objc class public func getDefaultStrWith(key:String) -> String {
        guard let conStr = AppClassUtilsHelper.getUserDefault(key: key), let conFinalStr:String = conStr as? String else {
            return ""
        }
        return conFinalStr
    }

    

    class func makeTopHudidAction(str: String) {
        
        DispatchQueue.main.async {
            let hud: MBProgressHUD = MBProgressHUD.showAdded(to:  UIApplication.shared.windows[0], animated: true)
            hud.mode = .text
            hud.label.text = str
            hud.label.textColor = UIColor.white
            hud.label.numberOfLines = 0
            hud.offset = CGPoint.init(x: 0, y: 0)
            hud.bezelView.style = .solidColor
            hud.bezelView.backgroundColor = UIColor.black
            hud.hide(animated: true, afterDelay: 1)
            
        }
    }
    

    class public func getRandomeStrAction (count:Int) -> String {
        var sourceStr = "abcd0123456789efghijklmnopqrstuvwxyz"
        var resStr = ""
        for i in 0 ... count-1 {
            let index = Int(arc4random_uniform(UInt32(sourceStr.count)))
            var conStr = NSString(format: "%@", sourceStr).substring(with: NSMakeRange(index, 1))
            resStr.append(contentsOf: conStr)   
        }
        return resStr
    }

    @objc class public func getNowTimeTimestamp() -> String {
        let date = NSDate();
        let timeSp = NSString.init(format: "%.f", date.timeIntervalSince1970 * 1000) as String
        return timeSp
    }
    
    
    @objc class public func encodeBase64Str (str:String) -> String {
        
        let strData = str.data(using: String.Encoding.utf8)
        let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
        
    }
    
    @objc class public func decodeBase64Str(str:String) -> String? {
        let decodedData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue) as String?
        return decodedString
    }
    
    
    
}


