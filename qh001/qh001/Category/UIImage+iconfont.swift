//
//  UIImage+iconfont.swift
//  ShowPay
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    @objc class func iconfont(text: String, size: CGFloat, color: UIColor) -> UIImage {
            let size = size
            let scale = UIScreen.main.scale
            let realSize = size * scale
            let font = UIFont.wqicon(size: realSize)
            UIGraphicsBeginImageContext(CGSize(width: realSize, height: realSize))
            let textStr = text as NSString
            if textStr.responds(to: NSSelectorFromString("drawAtPoint:withAttributes:")) {
                textStr.draw(at: CGPoint.zero, withAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
            }
            var image: UIImage = UIImage()
            if let cgimage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                image = UIImage(cgImage: cgimage, scale: scale, orientation: .up)
                UIGraphicsEndImageContext()
            }
            return image
        }
    @objc class func iconfont(text: String, size: CGFloat) -> UIImage {
            let size = size
            let scale = UIScreen.main.scale
            let realSize = size * scale
            let font = UIFont.wqicon(size: realSize)
            UIGraphicsBeginImageContext(CGSize(width: realSize, height: realSize))
            let textStr = text as NSString
            if textStr.responds(to: NSSelectorFromString("drawAtPoint:withAttributes:")) {
                textStr.draw(at: CGPoint.zero, withAttributes: [NSAttributedString.Key.font: font])
            }
            var image: UIImage = UIImage()
            if let cgimage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                image = UIImage(cgImage: cgimage, scale: scale, orientation: .up)
                UIGraphicsEndImageContext()
            }
            return image
        }
}
