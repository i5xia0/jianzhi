//
//  SPBaseModel.swift
//  ShowPay
//
//  Created by linke50 on 8/4/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import HandyJSON

class SPBaseModel: HandyJSON {
    var code: String? = "00"
    var msg: String?
    var status: String?
    var message: String?
    var timestamp: Any?
    var path: String?
    var error: String?
    
    required init() {}
}

class APIResultModel: SPBaseModel {
    var data: Any?
}

enum ErrorCode: String{
    case err  = "00" //接口错误
    case okm  = "0" //请求成功
    case ok  = "200" //请求成功
    case created     = "201" //请求失败
    case unauthorized  = "401" //请求成功
    case forbidden  = "403" //请求成功
}
