//
//  DeviceInfoManager.swift
//  ABCApp
//
//  Created by Boris on 2024/1/22.
//

import UIKit
import AdSupport
import CoreTelephony
import CoreFoundation
import SystemConfiguration.CaptiveNetwork
import SystemServices
import Network


class DeviceInfoManager: NSObject {
    
    
    class public func getDeviceNameAction () -> String {
        return UIDevice().phoneModel.replacingOccurrences(of: " ", with: "_");
    }
    
    class public func getIdfvAction () -> String {
        
        if let idfv = AppKeyStrong.keyChainReadData(identifier: "App-KeyStrong") as? String {
            return idfv
        }else{
            let uuidRef = CFUUIDCreate(nil)
            let uuidStringRef = CFUUIDCreateString(nil,uuidRef)
            var idfvStr = uuidStringRef! as String
            if idfvStr.count == 0 {
                idfvStr = "00000000-0000-0000-0000-000000000000"
                AppClassUtilsHelper .makeTopHudidAction(str: "Get idfv error")
            }
            let resulet = AppKeyStrong.keyChainSaveData(data: idfvStr, withIdentifier: "App-KeyStrong")
            if resulet == true {
                return idfvStr
            }else{
                AppClassUtilsHelper .makeTopHudidAction(str: "Save idfv error")
                let resulet = AppKeyStrong.keyChainSaveData(data: idfvStr, withIdentifier: "App-KeyStrong")
                return idfvStr;
            }
        }
    }
    
    class public func getLineJoinRoundView(frame: CGRect, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.white
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: lineView.bounds, cornerRadius: cornerRadius).cgPath
        lineView.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = nil
        borderLayer.lineWidth = borderWidth
        borderLayer.lineJoin = .round
        borderLayer.lineDashPattern = [10, 6] // 设置虚线的长度和间距，可以根据需要调整
        
        let borderPath = UIBezierPath(roundedRect: lineView.bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2), cornerRadius: cornerRadius)
        borderLayer.path = borderPath.cgPath
        
        lineView.layer.addSublayer(borderLayer)
        return lineView
    }

    
    

    class public func addRoundedRect(to view: UIView, topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let width = view.frame.size.width
        let height = view.frame.size.height

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))

        path.addLine(to: CGPoint(x: 0, y: height - bottomLeft))
        path.addArc(withCenter: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: .pi, endAngle: .pi / 2, clockwise: false)

        path.addLine(to: CGPoint(x: width - bottomRight, y: height))
        path.addArc(withCenter: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: .pi / 2, endAngle: 0, clockwise: false)

        path.addLine(to: CGPoint(x: width, y: 0))
        path.addArc(withCenter: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: 0, endAngle: -.pi / 2, clockwise: false)

        path.addLine(to: CGPoint(x: topLeft, y: 0))
        path.addArc(withCenter: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: -.pi / 2, endAngle: .pi, clockwise: false)

        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        shapeLayer.path = path.cgPath
        view.layer.mask = shapeLayer
    }



    
    
    
    @objc class public func getIDFA ()-> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    
    
    
    @objc class public func getSystemVersion() -> String {
        
        return UIDevice.current.systemVersion
    }
    
    @objc class public func getAppVersion() -> String {
        let infoDic: NSDictionary = Bundle.main.infoDictionary! as NSDictionary;
        let appVersion:String = infoDic.object(forKey: "CFBundleShortVersionString") as! String
        return appVersion;
    }
    
    @objc class public func getCurrentLanguage () -> String {
        let languages = NSLocale.preferredLanguages
        guard let current = languages.first else { return "" }
        return current
    }
    
    
    
    @objc class public func getBundleId() -> String {
        let infoDic: NSDictionary = Bundle.main.infoDictionary! as NSDictionary;
        let appVersion:String = infoDic.object(forKey: "CFBundleIdentifier") as! String
        return appVersion;
    }
    @objc class public func getBuildleVersion() -> String {
        let infoDic: NSDictionary = Bundle.main.infoDictionary! as NSDictionary;
        let appVersion:String = infoDic.object(forKey: "CFBundleVersion") as! String
        return appVersion;
    }
    
    
    class public func getBatterylevel () -> String {
        
        UIDevice.current.isBatteryMonitoringEnabled = true;
        let deviceLevel = UIDevice.current.batteryLevel;
        return NSString(format: "%.f", deviceLevel * 100) as String
        
    }
    
    class public func getBatteryStatus () -> String {
        
        UIDevice.current.isBatteryMonitoringEnabled = true;
        let batteryStatu = UIDevice.current.batteryState;
        if (batteryStatu == .charging){
            return "1";
        }else if (batteryStatu == .full){
            return "0";
        }
        return "0";
        
    }
    
    class public func getTimeZoneStr () -> String {
        let timeZone = NSTimeZone.system
        return timeZone.abbreviation() ?? "";
    }
    
    class public func getAppIsSimuLator () -> String {
#if targetEnvironment(simulator)
        return "1"
#else
        return "0"
#endif
    }
    
    class public func appIsConnectedToProxy() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
           let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [Any],
           let settings = proxies.first as? [AnyHashable: Any],
           let proxyType = settings[kCFProxyTypeKey] as? String {
            
            if proxyType == kCFProxyTypeNone as String {
                // 没有设置代理
                return "0"
            } else {
                // 设置代理了
                return "1"
            }
        }
        
        // 默认情况下认为没有设置代理
        return "0"
    }
    
    class public func appIsConnectedToVPN() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scopedProxySettings = proxySettings["SCOPED"] as? [String: Any] {
            
            for key in scopedProxySettings.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    print(">>>>>>开启了VPN")
                    return "1"
                }
            }
        }
        
        print(">>>>>>没有开启VPN")
        return "0"
    }
    
    class public func getAppRootStatus() -> String {
        var status1 = false
        var status2 = false
        
        // 根据是否能打开cydia判断
        if let cydiaURL = URL(string: "cydia://"), UIApplication.shared.canOpenURL(cydiaURL) {
            status1 = true
        }
        
        // 根据是否能获取所有应用的名称判断
        let applicationsPath = "/User/Applications/"
        status2 = FileManager.default.fileExists(atPath: applicationsPath)
        
        if status1 || status2 {
            // 如果有一种方式判定为设备越狱了，那么设备就越狱了，不接受任何反驳
            return "1"
        } else {
            return "0"
        }
    }
    
    class public func getAppCarrierInfoName() -> String {
        return SystemServices.shared().carrierName ??  "未知"
    }
    
    class public func getDeviceScreenSize() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone7,1": return "5.5"
        case "iPhone7,2", "iPhone8,1", "iPhone9,3", "iPhone10,1", "iPhone10,4", "iPhone11,8", "iPhone12,8": return "4.7"
        case "iPhone8,2", "iPhone9,2", "iPhone10,2", "iPhone10,5", "iPhone11,2", "iPhone12,1", "iPhone12,3", "iPhone12,5", "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", "iPhone14,4", "iPhone14,6", "iPhone14,7", "iPhone15,2", "iPhone16,1": return "5.5"
        case "iPhone8,4", "iPhone9,1", "iPhone9,4", "iPhone10,3", "iPhone10,6", "iPhone11,6", "iPhone11,4", "iPhone12,1", "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", "iPhone14,5", "iPhone14,2", "iPhone15,3", "iPhone15,5", "iPhone16,2", "iPhone16,2": return "4.0"
        case "iPhone10,3", "iPhone10,6", "iPhone11,8", "iPhone12,1", "iPhone14,7", "iPhone15,2": return "5.8"
        case "iPhone11,2", "iPhone13,4", "iPhone14,3", "iPhone14,5", "iPhone14,8", "iPhone15,3", "iPhone15,5", "iPhone16,1", "iPhone16,2": return "6.1"
        case "iPhone11,6", "iPhone12,5", "iPhone13,6", "iPhone14,8", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2": return "6.5"
        default: return identifier
        }
    }
    
    class public func getAppWifiBSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            
            currentSSID = myDict["BSSID"] as? String ?? ""
            
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    class public func getAppWifiSSIDInfo() -> String {
        var currentSSID = ""
        if let myArray = CNCopySupportedInterfaces() as? [String],
           let interface = myArray.first as CFString?,
           let myDict = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
            
            currentSSID = myDict["SSID"] as? String ?? ""
            
        } else {
            currentSSID = ""
        }
        return currentSSID
    }
    
    class public func getDeivceIPAddress() -> String {
        
        return SystemServices.shared().currentIPAddress ?? ""
        
    }
    
    class public func getDeivceTotalDiskSpace() -> String {
        return String(SystemServices.shared().longDiskSpace)
    }
    
    class public func getDeivceFreeDiskSpace() -> String {
        return String(SystemServices.shared().longFreeDiskSpace)
    }
    
    class public func getDeivceTotalmemory() -> String {
        let totalMemory = SystemServices.shared().totalMemory * 1024 * 1024
        return "\(Int(totalMemory))"
    }
    
    class public func getDeivceFreememory() -> String {
        let freeMemory = SystemServices.shared().activeMemoryinRaw * 1024 * 1024
        return "\(Int(freeMemory))"
    }
    
    class public func getDeivceName() -> String {
        return SystemServices.shared().deviceName ?? ""
    }
    
    class public func getCurrentMillis() -> String {
        return String(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
    /// 手机启动时间(毫秒)
    class public func mobilePhoneStartTime() -> String {
        let t: TimeInterval = ProcessInfo.processInfo.systemUptime
        let d = Date(timeIntervalSinceNow: 0 - t)
        let sp = String(format: "%ld", Int(d.timeIntervalSince1970))
        return sp
    }
    
    class public func getNetworkType() -> String {
        // 网络类型 WIFI, 4G, Bad Network, Unknown Network
        
        var networkType = "Unknown"
        if #available(iOS 12.0, *) {
            let monitor = NWPathMonitor()
            let semaphore = DispatchSemaphore(value: 0)
            
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    if path.usesInterfaceType(.wifi) {
                        networkType = "WIFI"
                    } else if path.usesInterfaceType(.cellular) {
                        networkType = "4G"
                    }
                } else {
                    networkType = "Bad Network"
                }
                semaphore.signal()
            }
            
            let queue = DispatchQueue(label: "NetworkMonitor")
            monitor.start(queue: queue)
            _ = semaphore.wait(timeout: .now() + 1) // Wait for 1 second (adjust as needed)
            monitor.cancel()
            return networkType
        } else {
            return networkType
            // Fallback on earlier versions
        }
    }
    
    
    class public func returnAppInfo () -> [String: Any] {
        
        let timeDifferenceStr = DeviceInfoManager.mobilePhoneStartTime()

        // 上次登录时间
        let loginTime =  AppClassUtilsHelper.getDefaultStrWith(key: LoginSuccessTime)

        return [
            "lights": "ios", // 系统类型
            "glory": DeviceInfoManager.getSystemVersion(), // 系统版本
            "baked": loginTime, // 上次登录时间，毫秒数
            "roots": DeviceInfoManager.getBundleId(), // 包名
            "feeding": [
                "traced":  DeviceInfoManager.getBatterylevel(), //电池百分比
                "itself": DeviceInfoManager.getBatteryStatus(), //是否正在充电(yes: 1, no: 0)
            ],
            "plant":[ //app不用管
                    ],
            
            "dwelling": [
                "liked": DeviceInfoManager.getIdfvAction(),
                "favorite": DeviceInfoManager.getIDFA(),
                // idfa
                "fished": DeviceInfoManager.getAppWifiBSSIDInfo(), // 设备mac
                "useful": DeviceInfoManager.getCurrentMillis(), // 系统当前时间，单位毫秒
                //    "ordered": "74553635", // 设备运行时间，单位毫秒 //忽略
                "fibers": DeviceInfoManager.appIsConnectedToProxy(), // 是否使用代理(yes:1,no:0)
                "cotton": DeviceInfoManager.appIsConnectedToVPN(), // 是否使用vpn(yes:1,no:0)
                "wooden": DeviceInfoManager.getAppRootStatus(), // 是否越狱(yes: 1, no: 0)
                "is_simulator" : DeviceInfoManager.getAppIsSimuLator(), // 是否是模拟器(yes: 1, no: 0)
                "choice": DeviceInfoManager.getCurrentLanguage(), // 设备语言
                "loose": DeviceInfoManager.getAppCarrierInfoName(), // 网络运营商名称
                "holes": DeviceInfoManager.getNetworkType(), // 网络类型 2G/3G/4G/5G/WIFI/OTHER
                "garment": [//ios忽略
                           ],
                "proper": DeviceInfoManager.getTimeZoneStr(), // 时区的 ID
                "selected": timeDifferenceStr // 设备启动毫秒数
            ],
            "deliberation": [
                "ruins": "", //给空字符串
                "purge": "iPhone", // 设备名牌
                "carvings": "",  //给空字符串
                "harmless": NSString(format: "%.f", kScreenHeight), // 设备高度
                "winks": DeviceInfoManager.getDeivceName(),
                "innocuous": NSString(format: "%.f", kScreenWidth), // 设备宽度
                "clues": DeviceInfoManager.getDeviceNameAction(), // 设备型号
                "artifacts": DeviceInfoManager.getDeviceScreenSize(), // 物理尺寸
                "flesh": DeviceInfoManager.getSystemVersion(), // 系统版本
            ],
            "wrist": [
                "bones": DeviceInfoManager.getDeivceIPAddress(),//内网ip
                "sticks": [
                    
                ],
                "pouch": [
                    "formed": DeviceInfoManager.getAppWifiSSIDInfo(), //  当前的 wifi 名称，传 SSID 即可
                    "matching": DeviceInfoManager.getAppWifiBSSIDInfo(), // 当前的 wifi BSSID
                    "fished": DeviceInfoManager.getAppWifiBSSIDInfo(), // 当前的 wifi MAC
                    "pairs": DeviceInfoManager.getAppWifiSSIDInfo(), // 当前的 wifi SSID
                ],
                "leather": 0
            ],
            "rested": [
                "knitting": DeviceInfoManager.getDeivceTotalDiskSpace(), // 未使用存储大小
                "needles": DeviceInfoManager.getDeivceFreeDiskSpace(),  // 总存储大小
                "chosen": DeviceInfoManager.getDeivceTotalmemory(), // 总内存大小
                "forlorn": DeviceInfoManager.getDeivceFreememory(),  // 未使用内存大小
            ]
        ]
        
        
    }
    
    
}
