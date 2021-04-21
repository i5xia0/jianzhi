//
//  WQMarketModel.swift
//  qh001
//
//  Created by linke50 on 4/8/21.
//

import UIKit
import HandyJSON

class WQMarketModel: HandyJSON {
    var contractFlag: String?
    var contractID:String?
    var contractName: String?
    var curVolume: String?
    var exShort: String?
    var futureType: Int32?
    var mainContract: String?
    var masukura: Int32?
    var nowV: String?
    var openInterest: String?
    var symbol: String?
    var upDown: String?
    var upDownRate: String?
    var varietyID: Int32?
    var openP: String?
    var highP: String?
    var lowP: String?
    var timeData: Array<WQMarketTimeModel>?
    required init() {}
}

class WQMarketTimeModel: HandyJSON {
    required init() {}
    var curVolume: Float? //curVolume = 2047; 成交价
    var curValue: Float?//curValue = 565043200; 成交量
    var highP: String?//highP = 69740; 最高价
    var lowP: String?//lowP = "-69660"; 最低价
    var nowV: String?//nowV = "-69690"; 最新价
    var openP:String?//openP = 69740;
    var preCloseP:String?//openP = 69740;
    var openInterest: Float?//openInterest = 379436; 持仓量
    var timeStamp: TimeInterval?
    /**
     longShortFlag = 0;
     openP = 69740;
     preCloseP = 69740;
     settlementPrice = 68740;
     upDown = "-50";
     upDownRate = "-0.07%";
     */
}
