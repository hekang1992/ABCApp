//
//  UIDevice+Extension.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import Foundation
import UIKit

extension UIDevice {
    
    var phoneModel: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8 , value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            
            switch identifier {
            case "iPod5,1":                                 return "iPod_Touch_5"
            case "iPod7,1":                                 return "iPod_Touch_6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone_4"
            case "iPhone4,1":                               return "iPhone_4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone_5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone_5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone_5s"
            case "iPhone7,2":                               return "iPhone_6"
            case "iPhone7,1":                               return "iPhone_6_Plus"
            case "iPhone8,1":                               return "iPhone_6s"
            case "iPhone8,2":                               return "iPhone_6s_Plus"
            case "iPhone8,4":                               return "iPhone_SE_(1st_generation)"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone_7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone_7_Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone_8"
            case "iPhone10,5", "iPhone10,2":                return "iPhone_8_Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone_X"
            case "iPhone11,2":                              return "iPhone_XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone_XS MAX"
            case "iPhone11,8":                              return "iPhone_XR"
            case "iPhone12,1":                              return "iPhone_11"
            case "iPhone12,3":                              return "iPhone_11 pro"
            case "iPhone12,5":                              return "iPhone_11 Pro Max"
            case "iPhone12,8":                              return "iPhone_SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone_12 mini"
            case "iPhone13,2":                              return "iPhone_12"
            case "iPhone13,3":                              return "iPhone_12 Pro"
            case "iPhone13,4":                              return "iPhone_12 Pro Max"
            case "iPhone14,4":                              return "iPhone_13 mini"
            case "iPhone14,5":                              return "iPhone_13"
            case "iPhone14,2":                              return "iPhone_13 Pro"
            case "iPhone14,3":                              return "iPhone_13 Pro Max"
            case "iPhone14,6":                              return "iPhone_SE (3rd generation)"
            case "iPhone14,7":                              return "iPhone_14"
            case "iPhone14,8":                              return "iPhone_14 Plus"
            case "iPhone15,2":                              return "iPhone_14 Pro"
            case "iPhone15,3":                              return "iPhone_14 Pro Max"
                
                
            case "iPhone15,4":                              return "iPhone_15"
            case "iPhone15,5":                              return "iPhone_15_Plus"
            case "iPhone16,1":                              return "iPhone_15_Pro"
            case "iPhone16,2":                              return "iPhone_15_Pro_Max"
                
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad7,11", "iPad7,12":                    return "iPad 7"
            case "iPad11,6", "iPad11,7":                    return "iPad 8"
            case "iPad12,1", "iPad12,2":                    return "iPad 9"
     
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air 3"
            case "iPad13,1", "iPad13,2":                    return "iPad Air 4"
            case "iPad13,16", "iPad13,17":                  return "iPad Air 5"
            
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad14,1", "iPad14,2":                    return "iPad Mini 6"
            case "iPad6,7", "iPad6,8", "iPad6,3", "iPad6,4", "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,9", "iPad8,10", "iPad8,11", "iPad8,12":         return "iPad Pro"
            case "AppleTV5,3":                              return "Apple TV"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
        }
        
    
}
