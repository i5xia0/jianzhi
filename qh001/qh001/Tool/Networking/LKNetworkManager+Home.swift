//
//  LKNetworkManager+Home.swift
//  ShowPay
//
//  Created by linke50 on 8/25/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation

extension LKNetworkManager {
    public func mainContract(type: String? = "4",success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var params = Dictionary<String,String> ()
        params["type"] = type
        self.postRequest(url: API_Path.mainContract, params: params, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
    public func getContract(contractid: String,type: String,success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var params = Dictionary<String,String> ()
        params["contractid"] = contractid
        params["type"] = type
        self.postRequest(url: API_Path.contractLine, params: params, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
    public func getNewsflash(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var header = Dictionary<String,String> ()
        header["bundleid"] = "com.laowuQH"
        self.postRequest(url: API_Path.newsflash, params: nil,header: header, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
    public func getNews(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var header = Dictionary<String,String> ()
        header["bundleid"] = "com.laowuQH"
        self.postRequest(url: API_Path.news, params: nil,header: header, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
    public func getVideoList(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var header = Dictionary<String,String> ()
        header["bundleid"] = "com.laowuQH"
        self.postRequest(url: API_Path.video, params: nil,header: header, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
    public func getBSSList(success: @escaping ResponseSuccess,
                                 fail: @escaping ResponseFail) {
        var header = Dictionary<String,String> ()
        header["bundleid"] = "com.laowuQH"
        self.postRequest(url: API_Path.BSSList, params: nil,header: header, success: { (result) -> (Void) in
            if result.code == ErrorCode.okm.rawValue {//请求成功
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
