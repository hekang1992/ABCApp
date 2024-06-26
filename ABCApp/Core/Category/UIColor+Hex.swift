//
//  UIColor+Hex.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

extension UIColor {
    
    /// WHAColor: Create color object from Hex String
    ///
    /// - Parameter hexString: hex color code (ex : #FFFFFF)
    public convenience init(_ hexString: String?) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    /// WHAColor: Create color object from Hex String
    ///
    /// - Parameter hexString: hex color code (ex : #FFFFFF)
    /// - Parameter alpha: alpha channel
    public convenience init(hexString: String?, alpha: Float = 1.0) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var mAlpha: CGFloat = CGFloat(alpha)
        var minusLength = 0
        
        guard (hexString != nil) else {
            self.init(red: red, green: green, blue: blue, alpha: 0)
            return
        }
        
        let scanner = Scanner(string: hexString!)
        
        if hexString!.hasPrefix("#") {
            scanner.scanLocation = 1
            minusLength = 1
        }
        if hexString!.hasPrefix("0x") {
            scanner.scanLocation = 2
            minusLength = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString!.count - minusLength {
        case 3:
            red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            blue = CGFloat(hexValue & 0x00F) / 15.0
        case 4:
            red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
            green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
            blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
            mAlpha = CGFloat(hexValue & 0x00F) / 15.0
        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            mAlpha = CGFloat(hexValue & 0x000000FF) / 255.0
        default:
            break
        }
        self.init(red: red, green: green, blue: blue, alpha: mAlpha)
    }
}


