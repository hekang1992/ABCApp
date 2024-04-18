//
//  InfomationModel.swift
//  ABCApp
//
//  Created by Boris on 2024/2/1.
//

import UIKit
import HandyJSON

class InfomationModel: HandyJSON {
    required init() {
    }
    

    var names : InfomationModel?
    var pause : String?  //证件是否完成 0、1
    var giving : String?  //证件图片地址
    var promoted : String = ""  //证件类型
    
    var jealous : String?   //人脸是否完成 0、1
//    var giving : String?  //人脸图片地址

    var regretting:Array<Any>?
    
    var weight : String? // id
    var formed : String? // name
    var shifted : String? // birthday
    
    var yiette : [HomeSubModel]?

}
