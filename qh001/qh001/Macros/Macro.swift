//
//  SStyleMacro.swift
//  qh
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit



//获取当前应用
var WQ_AppDelegate: AppDelegate? {
    get{
        if let app = UIApplication.shared.delegate as? AppDelegate {
            return app
        }
        return nil
    }
}

//获取当前窗口
var WQ_WINDOW: UIWindow? {
    get{
        if let app = UIApplication.shared.delegate as? AppDelegate {
            return app.window
        }
        return nil
    }
}
//2. iPhoneX系列
var iphoneX_Series: Bool {
    get {
        
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone{
            debugPrint("不是iPhone， 是 \(UIDevice.current.userInterfaceIdiom.rawValue)")
        }
        
        if #available(iOS 11.0, *) {
            if let bottom = WQ_WINDOW?.safeAreaInsets.bottom , bottom > 0 {
                return true
            }
        } else {
            debugPrint("iOS11 之前的版本")
        }
        return false
    }
}
//设备参数
let ScreenHeight = UIScreen.main.bounds.height
let ScreenWidth = UIScreen.main.bounds.width
var SafeAreaTopHeight: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            if let top = WQ_WINDOW?.safeAreaInsets.top , top > 0 {
                return top
            }
        }
        return 0.0
        
    }
}
var SafeAreaBottomHeight: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            if let bottom = WQ_WINDOW?.safeAreaInsets.bottom , bottom > 0 {
                return bottom
            }
        }
        return 0.0
    }
}
let StatusBarHeight = UIApplication.shared.statusBarFrame.height
let MainScreenScale = UIScreen.main.scale
let TabbarHeight: CGFloat = 49.0
let NabBarHeight: CGFloat = 44.0
let NavgationHeight = (CGFloat(StatusBarHeight) + CGFloat(NabBarHeight))

let SystemVersion = (UIDevice.current.systemVersion as NSString).floatValue
let SUserDefaults = UserDefaults.standard
let Notife = NotificationCenter.default
let AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
let SUUID =  UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "")



// 打印内容，并包含类名和打印所在行数
func DLog<T>(_ message : T,file : String = #file,function:String = #function, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let functionStr = function.split(separator: "(").first
    print("\n**************自定义日志输出：\(fileName):\(functionStr ?? "")():[\(lineNumber)]************** \n\(message) \n**************************************************")
    #endif
}
