//
//  FaceModel.swift
//  ABCApp
//
//  Created by Boris on 2024/2/5.
//

import UIKit
import HandyJSON

class FaceModel: HandyJSON {

    required init() {
    }
    
    var faked:String? //adv licence
    var wrinkles:String?  //人脸难易程度 0.normal 1.hard 2.easy
    var johnboy:String? //faceType:  1.自拍 2.望为 3.adv
    

    var reelection : String?
    var swelled : String?
    var speech : String?

}
