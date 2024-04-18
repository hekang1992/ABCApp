//
//  NSString+Extension.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

extension String {
    
    func URLDecodedString () -> String{
        
        return  self.removingPercentEncoding!
        
    }

    func toDictionary() -> [String : String] {
        
        var result = [String : String]()
        guard !self.isEmpty else { return result }
        
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                           options: .mutableContainers) as? [String : String] {
            result = dic
        }
        return result
    
    }
    
}
