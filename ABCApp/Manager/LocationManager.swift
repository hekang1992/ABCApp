//
//  LocationManager.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit
import CoreLocation




class LocationItem: NSObject {
    /// 经度
    var latitude:Double = 0
    /// 纬度
    var longitude:Double = 0
    /// 国家
    var country = ""
    /// 省
    var province = ""
    /// 市
    var city = ""
    /// 区
    var area = ""
    /// 街道
    var thoroughfare = ""
    /// 详细地址
    var address = ""
}
class LocationManager: NSObject {
    static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        // setup code
        instance.initialize()
        return instance
    }()
    var locationManager: CLLocationManager?
    var currentLcoation : CLLocation?

    
    public func initialize(){
        if (self.locationManager == nil) {
           self.locationManager = CLLocationManager()
           // 设置代理
           self.locationManager?.delegate = self
           // 设置定位精度
           locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters

        }
    }
    
    // 开始尝试获取定位
    public func startRequestLocation() {
        
        if (CLLocationManager.authorizationStatus() == .denied) {

            //
            self.postDeviceInfoAction()
        } else {
            print("开始")
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }

}
// 实现代理
extension LocationManager: CLLocationManagerDelegate {
    // 代理方法，位置更新时回调
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        let location = locations.last ?? CLLocation.init()
        let coordinate = location.coordinate
        self.currentLcoation = location
        let latitude = coordinate.latitude;
        let longitude = coordinate.longitude;
        print(String(latitude))
        print(longitude)
        self.locationManager?.stopUpdatingLocation()
        self.hw_getLocation(latitude, longitude)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            self.locationManager?.startUpdatingLocation()
        } else if (status == .authorizedWhenInUse) {
            self.locationManager?.startUpdatingLocation()
        } else if (status == .denied) {
            self.postDeviceInfoAction()
        }
    }

    // 当获取定位出错时调用
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 这里应该停止调用api
        self.locationManager?.stopUpdatingLocation()
    }
    
    // MARK: 反地理编码  经纬度->地址
       private func hw_getLocation(_ latitude:Double, _ longitude:Double) {
           let loc1 = CLLocation(latitude: latitude, longitude: longitude)
           let geoCoder = CLGeocoder()
           geoCoder.reverseGeocodeLocation(loc1) { [weak self] (pls: [CLPlacemark]?, error: Error?)  in
               if error == nil {
                   print("反地理编码成功")
                   guard let plsResult = pls else {return}
                   self?.getLocationItem(plsResult)
               }else {
                   print("错误")
                 
               }
           }
       }
       // MARK: 获取位置模型
       private func getLocationItem(_ pls: [CLPlacemark]) {
           let pl = pls.first
           
           let item = LocationItem()
           item.address = pl?.name ?? "" // 详细地址
           item.country = pl?.country ?? "" // 国家
           item.province = pl?.administrativeArea ?? "" // 省
           if item.province.isEmpty {
               item.province = (pl?.addressDictionary?["State"] ?? "") as! String
           }
           item.city = pl?.locality ?? "" // 市
           if item.city.isEmpty {
               item.city = (pl?.addressDictionary?["City"] ?? "") as! String
           }
           if item.city.isEmpty {
               item.city = pl?.administrativeArea ?? ""
           }
           var area = pl?.subLocality ?? ""
           if area.isEmpty {
               area = (pl?.addressDictionary?["SubLocality"] ?? "") as! String
           }
           if area.isEmpty {
               area = item.city
           }
           item.area = area // 区
           item.thoroughfare = pl?.thoroughfare ?? ""// 街道
           
           print("定位:\(item.thoroughfare)")
         
           if (AppCacheHelper.sharedInstance.isPostLocation == 0){
               
               AppCacheHelper.sharedInstance.isPostLocation = 1
               
               let postParams = [
                "twirling":item.province,  //省
                 "tumbled": "CN",//国家code
                "windswept": item.country,//国家
                "eddies": item.thoroughfare,
                "smaller": String(self.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(self.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "ominous": item.city,//市
                "slope": AppClassUtilsHelper.getRandomeStrAction(count: 10),//混淆字段
                "comes": AppClassUtilsHelper.getRandomeStrAction(count: 5)//混淆字段
               ]
               print("aaa  -- 上报 locaiton")
               AppHelper.showLoading()
               AppNetHelper.post_couldntKneesAction(params: postParams) { succ in
                   print("aaa  -- 上报 locaiton 成功")
                   AppHelper.hid()
               } fail: { fail in
                   AppHelper.hid()
                   print("aaa  -- 上报 locaiton 失败")
                   AppCacheHelper.sharedInstance.isPostLocation = 0

               }
               self.postDeviceInfoAction()
               
           }
           
       }

    
    func postDeviceInfoAction (){
        
        if (AppCacheHelper.sharedInstance.isPostDevice == 0){
            
            AppCacheHelper.sharedInstance.isPostDevice = 1
            
            let postParams = DeviceInfoManager.returnAppInfo()
               // 将Data对象转换为字符串
            if var jsonString = self.dictionary(toJson: postParams) {
                jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
                print("aaa  -- 上报 设备信息")
                AppNetHelper.post_againOrbitAction(params: ["mcneil":AppClassUtilsHelper.encodeBase64Str(str: jsonString)]) { succ in
                    print("aaa  -- 上报 设备成功")
                } fail: { fail in
                    print("aaa  -- 上报 设备信息失败")
                    AppCacheHelper.sharedInstance.isPostDevice = 0
                }
            }
        }
        
        // 上报登录成功
        let isUploadLoginStr = AppClassUtilsHelper.getDefaultStrWith(key: isUploadLogin)
        if (isUploadLoginStr != "1"){
            AppClassUtilsHelper.saveUserDefault(value: "1", key: isUploadLogin)
            
            let loginStartTime = AppClassUtilsHelper.getDefaultStrWith(key: GetCodetTimeKey)
            let loginEndTime = AppClassUtilsHelper.getDefaultStrWith(key: LoginSuccessKey)
            
            let postParams:[String:String] = [
                "judicial": "",   // 产品ID
                "triangle": "1",  // 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
                "toying": "",  // 用户申贷全局订单号，不用管
                "crafted": DeviceInfoManager.getIdfvAction(), // idfv
                "looped": DeviceInfoManager.getIDFA(),  //苹果：idfa，安卓gaid
                "smaller": String(self.currentLcoation?.coordinate.latitude ?? 0),//维度
                "today": String(self.currentLcoation?.coordinate.longitude ?? 0) ,//经度
                "practiced": loginStartTime ?? "", // 开始时间
                "quicker": loginEndTime ?? "" ,   // 结束时间
                "morbidity": AppClassUtilsHelper.getRandomeStrAction(count: 10), // 混淆字段
            ]
            print("aaa  -- 上报 登录信息 \(postParams)")
            
            AppNetHelper.post_tongueMakingAction(params: postParams) { succ in
                print("aaa  -- 上报 登录信息 成功")

            } fail: { fail in
                print("aaa  -- 上报 登录信息 失败")

                AppClassUtilsHelper.saveUserDefault(value: "0", key: isUploadLogin)
            }

            
            
        }
        
    }
    
    func dictionary(toJson dic: [String:Any]) -> String? {
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        }catch let parseError {
            print("(parseError.localizedDescription)")
        }
        if let jsonData = jsonData {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
        
    }
    

}

