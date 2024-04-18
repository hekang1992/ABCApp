//
//  EmergencyContactModel.swift
//  ABCApp
//
//  Created by Boris on 2024/2/4.
//

import UIKit
import HandyJSON

class EmergencyContactModel: HandyJSON {

    required init() {
    }
    
    var formed : String?
    var beckoned : String?
    var impression : String?
    var array : String?
    var wants : String?
    var wrinkles: String?
    var consciences:Array<EmergencyContactModel> = []
    var selformed : String?
    var relation_name : String?
}
