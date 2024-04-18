//
//  ProductModel.swift
//  ABCApp
//
//  Created by Boris on 2024/2/1.
//

import UIKit
import HandyJSON

class ProductModel: HandyJSON {

    required init() {
    }
    

    var giving : String?
    
    
    // detail
    var concern : ProductModel?
    var toying : String?
    var honestly : ProductModel?
    var judge : String?
    var decide : String?
    var tornado:Array<ProductModel> = []
    var pause : String?
    var squeaked : String?
    var audit_face: String?
    var personal : personalModel?
}


class personalModel: HandyJSON {
    required init() {
    }
    var str1: String?
    var str2: String?
    var str3: String?
    var str4: String?
    var str5: String?
}
