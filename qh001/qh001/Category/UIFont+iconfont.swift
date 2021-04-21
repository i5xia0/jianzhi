//
//  UIFont+iconfont.swift
//  ShowPay
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit


public extension UIFont {
    @objc class func showicon(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "show icon", size: ofSize)
    }
    @objc class func iconfont(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "iconfont", size: ofSize)
    }
    @objc class func wqicon(size: CGFloat) -> UIFont {
            let font = UIFont(name: "iconfont_wq", size: size)
            if font == nil {
                assert((font != nil), "UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.")
            }
            return font ?? UIFont.systemFont(ofSize: 18)
        }
    
}
