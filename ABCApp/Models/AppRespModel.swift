//
//  AppRespModel.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit
import HandyJSON

class AppRespModel: HandyJSON {
    required init() {
    }
    
    var supply : String?
    var msg: String?
    var marched: String?
    var mcneil: Any?
}
