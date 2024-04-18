//
//  AddressHelper.swift
//  ABCApp
//
//  Created by Boris on 2024/2/2.
//

import UIKit
import HandyJSON

typealias AddressHelperBlockClass = ( _ addressModel:AddressModel) -> ()


class AddressHelper: NSObject {

    var addressModel:AddressModel = AddressModel()

    var addressBlock : AddressHelperBlockClass?
    
    static let sharedInstance: AddressHelper = {
        let instance = AddressHelper()
        // setup code
        return instance
    }()
    

    func getAddressAction (block: @escaping AddressHelperBlockClass) -> Void {
        addressBlock = block
        if (addressModel.sting.count != 0){
            addressBlock!(addressModel)
            return
        }
        
        AppNetHelper.get_askedCheeksAction(params: [:]) { succ in
            
            let conDic = succ.mcneil as! [String:Any]
            
            let conModel = JSONDeserializer<AddressModel>.deserializeFrom(dict: conDic)
            self.addressModel = conModel!
            self.addressBlock!(self.addressModel)

            
        } fail: { fail in
            
        }

        
        
        
        
    }
    
    
}
