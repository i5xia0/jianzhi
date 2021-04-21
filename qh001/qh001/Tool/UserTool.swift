//
//  UserTool.swift
//  qh001
//
//  Created by linke50 on 4/9/21.
//

import UIKit

class UserTool {
    static let  shared  = UserTool()
    var isLogin: Bool! {
        get{
            let userData = UserDefaults.standard.object(forKey: "userData") as? Dictionary<String,Any>
            if userData != nil {
                UserTool.shared.user = WQUserModel.deserialize(from: userData)
                return true
            }else {
                UserTool.shared.user = nil
                return false
            }
        }
    }
    var userName: String {
        return "明日之星" + (user?.ID)!
    }
    var user: WQUserModel?
    func login(userData:Any) {
        //存储用户消息
        UserDefaults.standard.setValue(userData, forKey: "userData")
    }
    func logout() {
        UserDefaults.standard.setValue(nil, forKey: "userData")
    }
    var likes = Array<Int>()
    var comments = Dictionary<Int, Array<WQCommentModel>>()
    var shielding = Array<Int>()
}
