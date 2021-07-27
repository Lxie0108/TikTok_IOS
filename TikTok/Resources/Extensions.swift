//
//  Extensions.swift
//  TikTok
//
//  Created by Ling Xie on 7/27/21.
//

import Foundation
import UIKit

extension UIView{
    var width: CGFloat{
        return frame.size.width
    }
    var height: CGFloat{
        return frame.size.height
    }
    var left: CGFloat{
        return frame.origin.x
    }
    var right: CGFloat{
        return left + width
    }
    var top: CGFloat{
        return frame.origin.y
    }
    var botton: CGFloat{
        return top + height
    }
    
}
