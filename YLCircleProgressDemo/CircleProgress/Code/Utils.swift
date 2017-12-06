//
//  Utils.swift
//  YLCircleProgressDemo
//
//  Created by liyulong on 2017/12/5.
//  Copyright © 2017年 杰能软件. All rights reserved.
//

import Foundation
import UIKit

extension Float{
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
    var cgDouble: Double{
        return Double(self)
    }
}
extension CGFloat{
    var float: Float{
        return Float(self)
    }
}
extension Int{
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
}
struct RGB {
    var r:CGFloat
    var g:CGFloat
    var b:CGFloat
    var alpha:CGFloat? = 1.0
    
    init(r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, alpha:CGFloat? = 1.0) {
        self.r = r
        self.g = g
        self.b = b
        self.alpha = alpha
    }
    
}
extension RGB{
    var color:UIColor{
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue:CGFloat( b/255.0), alpha: 1.0)
    }
}
