//
//  WQStyleMacro.swift
//   
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit

//icon
public enum IconFont: String {
    case HOME   = "\u{e614}"
    case Market = "\u{e62a}"
    case BBS    = "\u{e650}"
    case My     = "\u{e882}"
}

//字体大小
struct SFONT {
    static let System10 = UIFont.systemFont(ofSize: 10)
    static let System12 = UIFont.systemFont(ofSize: 12)
    static let System15 = UIFont.systemFont(ofSize: 15)
    static let System16 = UIFont.systemFont(ofSize: 16)
    static let System20 = UIFont.systemFont(ofSize: 20)
    static let System24 = UIFont.systemFont(ofSize: 24)
    
    static let PingFang08 = UIFont(name: "PingFang SC", size: 08)
    static let PingFang10 = UIFont(name: "PingFang SC", size: 10)
    static let PingFang12 = UIFont(name: "PingFang SC", size: 12)
    static let PingFang15 = UIFont(name: "PingFang SC", size: 15)
    static let PingFang16 = UIFont(name: "PingFang SC", size: 16)
    static let PingFang20 = UIFont(name: "PingFang SC", size: 20)
    static let PingFang24 = UIFont(name: "PingFang SC", size: 24)
    //Helvetica-Bold
    static let Bold18 = UIFont(name: "Helvetica-Bold", size: 18)
    static let Bold12 = UIFont(name: "Helvetica-Bold", size: 12)
}

// 基础配色
struct COLOR_Base {
    static let SFFFFFF = SRGBHEXCOLOR(rgbValue: 0xFFFFFF)
    static let SF5F7FA = SRGBHEXCOLOR(rgbValue: 0xF5F7FA)
    static let SEAB300 = SRGBHEXCOLOR(rgbValue: 0xEAB300)
    static let S303133 = SRGBHEXCOLOR(rgbValue: 0x303133)
    static let S606266 = SRGBHEXCOLOR(rgbValue: 0x606266)
    static let SBFC2CC = SRGBHEXCOLOR(rgbValue: 0xBFC2CC)
    static let SEDEFF2 = SRGBHEXCOLOR(rgbValue: 0xEDEFF2)
    static let SFC6D5E = SRGBHEXCOLOR(rgbValue: 0xFC6D5E)
    static let S909399 = SRGBHEXCOLOR(rgbValue: 0x909399)
    static let S171734 = SRGBHEXCOLOR(rgbValue: 0x171734)
    static let SEAC600 = SRGBHEXCOLOR(rgbValue: 0xEAC600)
    static let S8E8E8E = SRGBHEXCOLOR(rgbValue: 0x8E8E8E)
    static let S32BD53 = SRGBHEXCOLOR(rgbValue: 0x32BD53)
    static let S617FFF = SRGBHEXCOLOR(rgbValue: 0x617FFF)
    static let S2FC78C = SRGBHEXCOLOR(rgbValue: 0x2FC78C)
    static let S509EFF = SRGBHEXCOLOR(rgbValue: 0x509EFF)
    static let S303133_85 = SRGBAHEXCOLOR(rgbValue: 0x303133,a: 0.85)
    static let S000000_60  = SRGBAHEXCOLOR(rgbValue: 0x000000,a: 0.6)
    static let S000000_10  = SRGBAHEXCOLOR(rgbValue: 0x000000,a: 0.1)
}


