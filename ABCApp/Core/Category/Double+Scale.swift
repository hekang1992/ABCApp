//
//  Double+Scale.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

extension Double {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0*kScreenWidth)
    }
}

extension CGFloat {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0*kScreenWidth)
    }
}

extension Int {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0*kScreenWidth)
    }
}

extension CGFloat {
    
    func minus() -> CGFloat{
        return 0 - self
    }
    
}
