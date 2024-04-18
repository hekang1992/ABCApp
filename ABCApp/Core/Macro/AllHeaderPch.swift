//
//  AllHeaderPch.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kIsNotchScreen = AppClassUtilsHelper .isNotchPhoneScreenAction()

let kNavigationBarHeight:CGFloat =  kIsNotchScreen ? 88.0 : 64.0
let kTabBarHeight:CGFloat =  kIsNotchScreen ? 83.0 : 49.0

let kStatusHeight:CGFloat =  kIsNotchScreen ? 44.0 : 20.0

let kBottomSafeHeight:CGFloat =  kIsNotchScreen ? 34.0 : 0.0
let kTopSafeHeight:CGFloat =  kIsNotchScreen ? 44.0 : 0.0

let kTabBottomSafeHeight:CGFloat =  kIsNotchScreen ? 20.0 : 0.0


let kCustomTabBarHeight:CGFloat =  kIsNotchScreen ? 100.0 : 95.0


let kOSBold = "OleoScript-Bold"
let kOSRegular = "OleoScript-Regular"


let sessionUser = "sessionUser"
let mobileUser = "mobileUser"
let firLaunchKey = "firLaunchKey"
let isUploadLogin = "isUploadLogin"
let GetCodetTimeKey = "GetCodetTimeKey"
let LoginSuccessKey = "LoginSuccessKey"
let LoginSuccessTime = "LoginSuccessTime" // 上次登录时间

let PPURL = ApiPrefix + "/speechesWorse"
let PPUR1L = ApiPrefix + "/smartMarch"
