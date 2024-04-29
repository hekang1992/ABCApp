//
//  AppNetManager.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit
import Alamofire
import HandyJSON

import AdSupport
import CoreFoundation


public let alamofireManager: Session = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 20
    return Session(configuration: config, delegate: SessionDelegate(), serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:]))
}()


@discardableResult
public func request(_ method: HTTPMethod, _ urlStr: String, _ parameters: Parameters? = nil, _ encoding: ParameterEncoding = URLEncoding(), _ headers: [String: String]? = nil, _ timeOutDruation: Int = 15) -> DataRequest {
    let fullParameters = parameters ?? [:]
    let fullHeaders = headers ?? [:]
    var baseApiUrl = UserDefaults.standard.object(forKey: APIBAERURL) as? String ?? ""
    if baseApiUrl.isEmpty {
        baseApiUrl = BaseApi
    }else {
        UserDefaults.standard.set(baseApiUrl, forKey: APIBAERURL)
        UserDefaults.standard.synchronize()
    }
    let urlConStr = baseApiUrl + urlStr + "?" + AppAFNetManager.getPublicParamsAction()
    print(urlConStr)
    print(fullParameters)
    let url: URL = URL(string: urlConStr)!

    alamofireManager.sessionConfiguration.timeoutIntervalForRequest = TimeInterval(timeOutDruation)

    return alamofireManager.request(url, method: method, parameters: fullParameters, encoding: encoding, headers: HTTPHeaders(fullHeaders))
}

@discardableResult
public func requestFormData(_ method: HTTPMethod, _ urlStr: String, _ image: UIImage,  _ parameters: Parameters? = nil, _ encoding: ParameterEncoding = URLEncoding(), _ headers: [String: String]? = nil) -> UploadRequest {
    let fullParameters = parameters ?? [:]
    let fullHeaders = headers ?? [:]
    var baseApiUrl = UserDefaults.standard.object(forKey: APIBAERURL) as? String ?? ""
    if baseApiUrl.isEmpty {
        baseApiUrl = BaseApi
    }else {
        UserDefaults.standard.set(baseApiUrl, forKey: APIBAERURL)
        UserDefaults.standard.synchronize()
    }
    let urlConStr = baseApiUrl + urlStr + "?" + AppAFNetManager.getPublicParamsAction()
    let url: URL = URL(string: urlConStr)!

    return alamofireManager.upload(multipartFormData: { data in
        
        if let imageData = compressionImage(image) {
            let key = "chooses"
            let fileName = "\(Date().timeIntervalSince1970).jpg"
            data.append(imageData, withName: key, fileName: fileName, mimeType: "image/jpeg")
        }
        for (key, value) in fullParameters {
            if let encodeData = (value as? String)?.data(using: .utf8) {
                data.append(encodeData, withName: key)
            }
        }
        
    }, to: url, method: method, headers: HTTPHeaders(fullHeaders))
}

private func compressionImage(_ image: UIImage) -> Data? {
    var compression: CGFloat = 1.0
    let maxFileSize: CGFloat = 1024.0 // 1024KB
    
    guard var compressedImageData = image.jpegData(compressionQuality: compression) else {
        return nil
    }
    
    // Continue compressing the image until the size is within the desired range
    while CGFloat(compressedImageData.count) / 1024.0 > maxFileSize {
        compression -= 0.1
        guard let newCompressedImageData = image.jpegData(compressionQuality: compression) else {
            return nil
        }
        compressedImageData = newCompressedImageData
    }
    
    return compressedImageData
}

class AppAFNetManager: NSObject {



    
    class public func getAction(url : String, params: [String : String], loading: Bool = false, success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        
        if (loading){
            AppHelper.showLoading()
        }
        let requst:DataRequest = request(.get, url, params)
        requst.response { resp in
            if (loading){
                AppHelper.hid()
            }
            if resp.data != nil {
                let JSONString = NSString(data:resp.data! ,encoding: String.Encoding.utf8.rawValue)
                NSLog("%@---%@",url,  JSONString ?? "value-if-nil")
                let respModel = JSONDeserializer<AppRespModel> .deserializeFrom(json: JSONString as String?)
                
                if respModel?.marched == "0" || respModel?.marched == "00" {
                    success(respModel!)
                }else if respModel?.marched == "-2" || respModel?.marched == "02" {
                    // 未登录 登录
                    self.showLoginViewAction()
                }else{
                    AppClassUtilsHelper.makeTopHudidAction(str: respModel?.supply ?? "")
                    fail(respModel ?? AppRespModel())
                }
            }else {
                fail(AppRespModel())
            }
        }
        
    }
//    
    class public func postAction(url : String, params: [String : String], loading: Bool = false, success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        if (loading){
            AppHelper.showLoading()
        }
        let requst:DataRequest = request(.post, url, params)
        requst.response { resp in
            if (loading){
                AppHelper.hid()
            }
            if resp.data != nil {
                let JSONString = NSString(data:resp.data! ,encoding: String.Encoding.utf8.rawValue)
                NSLog("%@---%@",url,  JSONString ?? "value-if-nil")
                let respModel = JSONDeserializer<AppRespModel> .deserializeFrom(json: JSONString as String?)
                
                if respModel?.marched == "0" || respModel?.marched == "00" {
                    success(respModel!)
                    
                }else if respModel?.marched == "-2" || respModel?.marched == "02" {
                    // 未登录 登录
                    self.showLoginViewAction()
                }else{
                    AppClassUtilsHelper.makeTopHudidAction(str: respModel?.supply ?? "")
                    fail(respModel ?? AppRespModel())
                }
            }
        }
    }
    
    
    
    class public func upPostAction(url : String, params: [String : String], img: UIImage, loading: Bool = false, success: @escaping (_ succ:AppRespModel) -> (), fail: @escaping (_ fail:AppRespModel) -> ()){
        if (loading){
            AppHelper.showLoading()
        }
        let requst:DataRequest = requestFormData(.post, url, img, params)
        requst.response { resp in
            if (loading){
                AppHelper.hid()
            }
            if resp.data != nil {
                let JSONString = NSString(data:resp.data! ,encoding: String.Encoding.utf8.rawValue)
                NSLog("%@---%@",url,  JSONString ?? "value-if-nil")
                let respModel = JSONDeserializer<AppRespModel> .deserializeFrom(json: JSONString as String?)
                
                if respModel?.marched == "0" || respModel?.marched == "00" {
                    success(respModel!)
                }else if respModel?.marched == "-2" || respModel?.marched == "02" {
                    // 未登录 登录
                    self.showLoginViewAction()
                }else{
                    AppClassUtilsHelper.makeTopHudidAction(str: respModel?.supply ?? "")
                    fail(respModel ?? AppRespModel())
                }
            }
        }
        
    }

    class func showLoginViewAction (){
        
         let loginView:LoginView = LoginView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
         let appdelegate = UIApplication.shared.delegate as! AppDelegate
         loginView.selblockSuccessAction {
             print("")
             let navi = appdelegate.rootTabBarVC.children.first as! BaseNC
             let homeVC = navi.children.first as! HomeVC
             homeVC.getAppHomeBigDataAction()
             homeVC.startLocationAction()
         }

        let vc = getCurrentUIVC() as! UIViewController
        vc.view.addSubview(loginView)
    }
    
    class public func getPublicParamsAction () -> String{
        
        
        var conDic : [String:String] = [
            "attempt":"ios", // 终端版本，取值范围： ios
            "misguided": DeviceInfoManager.getAppVersion(),  // App版本，例如：1.0.0
            "unpleasant":DeviceInfoManager.getDeviceNameAction(),  // 设备名称，例如：iphoneX
            "sensor": DeviceInfoManager.getIdfvAction(),        // 给idfv
            "ablative":DeviceInfoManager.getSystemVersion(),      // 设备os版本
            "prevent":"acsh",
            "fibbing":  DeviceInfoManager.getIdfvAction(),           // 取idfv
            "change":AppClassUtilsHelper.getRandomeStrAction(count: 20),
            "phonecode" : AppClassUtilsHelper.getDefaultStrWith(key: mobileUser)
        ]
        
        let sessionStr = AppClassUtilsHelper.getDefaultStrWith(key: sessionUser)
        
        if ( sessionStr.count > 0){
            conDic["nobody"] = sessionStr
        }
                
        let keysArray = Array(conDic.keys)
        
        var arr:Array = [String]();
        for keyStr in keysArray {
            let conStr:String = conDic[keyStr]!
            let respStr = NSString(format: "%@=%@", keyStr, conStr)
            arr.append(respStr as String)
        }
        let finalStr = arr.joined(separator:"&");
        NSLog("%@", arr)
        NSLog("%@", finalStr)
        
        return finalStr.replacingOccurrences(of: " ", with: "")
        
    }

}

 
