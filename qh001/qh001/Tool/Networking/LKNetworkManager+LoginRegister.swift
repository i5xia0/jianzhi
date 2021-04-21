//
//  LKNetworkManagerLoginRegister.swift
//  ShowPay
//
//  Created by linke50 on 8/4/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation

extension LKNetworkManager {
    /**
     注册
     */
    public func register(username:String,password: String,success: @escaping ResponseSuccess,
                                            fail: @escaping ResponseFail) {
        var params = Dictionary<String,String> ()
        params["username"] = username
        params["password"] = password
        self.postRequest(url: API_Path.register, params: params, success: { (result) -> (Void) in
            if result.code == ErrorCode.ok.rawValue {//请求成功
                success(result)
            }else if  result.code == ErrorCode.err.rawValue {
                fail(result.message ?? "error")
            }else {
                fail(result.msg ?? "error")
            }
        }) { (error) -> (Void) in
            fail(String(describing: error))
        }
    }
    public func login(username:String,password: String,success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var params = Dictionary<String,String> ()
        params["username"] = username
        params["password"] = password.md5()
        self.postRequest(url: API_Path.login, params: params, success: { (result) -> (Void) in
            if result.code == ErrorCode.ok.rawValue {//请求成功
                success(result)
            }else if  result.code == ErrorCode.err.rawValue {
                fail(result.message ?? "error")
            }else {
                fail(result.msg ?? "error")
            }
        }) { (error) -> (Void) in
            fail(String(describing: error))
        }
    }
    public func getInfo(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var header = Dictionary<String,String> ()
        header["token"] = UserTool.shared.user?.token
        self.postRequest(url: API_Path.getInfo, params: nil,header: header, success: { (result) -> (Void) in
            if result.code == ErrorCode.ok.rawValue {//请求成功
                success(result)
            }else if  result.code == ErrorCode.err.rawValue {
                fail(result.message ?? "error")
            }else {
                fail(result.msg ?? "error")
            }
        }) { (error) -> (Void) in
            fail(String(describing: error))
        }
    }
}
