//
//  SPUserModel.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//Copyright © 2020 50. All rights reserved.
//

import Foundation

class WQUserModel: SPBaseModel {
    var ID: String?
    var username: String?
    var token: String?
    var created: String?
    var lastLoginTime: String?
}
/*
 "ID" : 411,
 "token" : "NTY0NGVjYjhkMzExOGM2ZTRlNzZkMTA4YTI1YjAxNTk=",
 "created" : "2021-04-09 19:53:52",
 "username" : "Qwe004",
 "lastLoginTime" : "2021-04-09 19:54:04",
 "password" : "200820e3227815ed1756a6b531e7e0d2"
 */
class WQUserInfo: SPBaseModel {
    var userName: String?
    var toke: String?
}
