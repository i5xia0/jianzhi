//
//  SPUserInfo.swift
//  ShowPay
//
//  Created by linke50 on 7/29/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPUserInfo: NSObject {

    var username: String = ""
    var avatar: String = ""
    
    init(name: String, logo: String) {
        self.username = name
        self.avatar = logo
    }
    
}
