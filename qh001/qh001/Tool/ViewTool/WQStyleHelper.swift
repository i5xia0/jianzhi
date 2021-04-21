//
//  WQStyleHelper.swift
//   
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

func ADAPTWIDTH(_ x: CGFloat) -> CGFloat {
    return (ScreenWidth/360.0) * x
}

func SLocalizedString(_ key:String) -> String {
    return NSLocalizedString(key, comment: "")
}


func SImage(name:String) -> UIImage?{
    return UIImage(named: name)
}

func SFont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}

func SRGBCOLOR(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
    return SRGBACOLOR(r: r, g: g, b: b, a: 1.0)
}

func SRGBACOLOR(r:CGFloat,g:CGFloat,b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor(red:  r/255.0, green: g/255.0, blue:  b/255.0, alpha: a)
}
//RGB 16进制转换
func SRGBHEXCOLOR(rgbValue: UInt) -> UIColor {
    return SRGBAHEXCOLOR(rgbValue: rgbValue, a: 1.0)
}
func SRGBAHEXCOLOR(rgbValue: UInt, a: CGFloat) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: a
    )
}

func bytes(from hexStr: String) -> [UInt8] {
       assert(hexStr.count % 2 == 0, "输入字符串格式不对，8位代表一个字符")
       var bytes = [UInt8]()
       var sum = 0
       // 整形的 utf8 编码范围
       let intRange = 48...57
       // 小写 a~f 的 utf8 的编码范围
       let lowercaseRange = 97...102
       // 大写 A~F 的 utf8 的编码范围
       let uppercasedRange = 65...70
       for (index, c) in hexStr.utf8CString.enumerated() {
           var intC = Int(c.byteSwapped)
           if intC == 0 {
               break
           } else if intRange.contains(intC) {
               intC -= 48
           } else if lowercaseRange.contains(intC) {
               intC -= 87
           } else if uppercasedRange.contains(intC) {
               intC -= 55
           } else {
               assertionFailure("输入字符串格式不对，每个字符都需要在0~9，a~f，A~F内")
           }
           sum = sum * 16 + intC
           // 每两个十六进制字母代表8位，即一个字节
           if index % 2 != 0 {
               bytes.append(UInt8(sum))
               sum = 0
           }
       }
       return bytes
   }

