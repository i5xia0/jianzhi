//
//  LKNetworkManager.swift
//  ShowPay
//
//  Created by linke50 on 8/4/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony
import Alamofire
import SwiftyJSON

typealias ResponseSuccess = (APIResultModel) -> (Void)
typealias ResponseFail = (_ error:String) -> (Void)
typealias LKNetworkStatusBlock = (_ LKNetworkStatus: Int32) -> Void

enum LKNetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case cellular         = 1//蜂窝网  2、3、4、5G网络
    case wifi             = 2//wifi网络
}

class LKNetworkManager {
    static let shared = LKNetworkManager()
    private  lazy var manager: Session = {
        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = httpHeaders
        configuration.timeoutIntervalForRequest = timeout//请求超时时间
        return Session(configuration: configuration)
    }()
    ///baseURL,可以通过修改来实现切换环境
    private var privateNetworkBaseUrl: String? = API_BASE
    ///默认超时时间
    private var timeout: TimeInterval = 45
    ///当前网络状态
    private var NetworkStatus: LKNetworkStatus = LKNetworkStatus.wifi
    /**** 请求header
     *  根据后台需求,如果需要在header中传类似token的标识
     *  就可以通过在这里设置来实现全局使用
     *  这里是将token存在keychain中,可以根据自己项目需求存在合适的位置.
     */
    private var httpHeaders: [String:String]? = [
        "Content-type" : "application/x-www-form-urlencoded"
    ]
    
    //get请求
    public func getRequest(url: String,
                           params: [String: Any]?,
                           success: @escaping ResponseSuccess,
                           fail: @escaping ResponseFail) {
        requestWith(url: url, params: params, success: success, fail: fail)
    }
    //post请求
    public func postRequest(url: String,
                            params: [String: Any]?,
                            success: @escaping ResponseSuccess,
                            fail: @escaping ResponseFail) {
        requestWith(url: url,httpMethod:.post, params: params, success: success, fail: fail)
    }
    //post请求添加header
    public func postRequest(url: String,
                            params: [String: Any]?,
                            header: [String: String]?,
                            success: @escaping ResponseSuccess,
                            fail: @escaping ResponseFail) {
        if header != nil {
            for key in header!.keys {
                httpHeaders![key] = header![key]
            }
        }
        requestWith(url: url,httpMethod:.post, params: params, success: success, fail: fail)
    }
    ///核心方法
    private func requestWith(url: String,
                             httpMethod: HTTPMethod = .get,
                             params: [String: Any]?,
                             success: @escaping ResponseSuccess,
                             fail: @escaping ResponseFail) {
        if (self.baseUrl() == nil) {
            if URL(string: url) == nil {
                DLog("URLString无效")
                return
            }
        } else {
            if URL(string: "\(self.baseUrl()!)\(url)" ) == nil {
                DLog("URLString无效")
                return
            }
        }
        let encodingUrl = encodingURL(path: url)
        let absolute = absoluteUrlWithPath(path: encodingUrl)
        let lastUrl = buildAPIString(path: absolute)
        //打印header进行调试.
        if let params = params {
            DLog("\(lastUrl)\nheader =\(String(describing: httpHeaders))\nparams = \(params)")
        } else {
            DLog("\(lastUrl)\nheader =\(String(describing: httpHeaders))")
        }
        //无网络状态获取缓存
        if NetworkStatus.rawValue == LKNetworkStatus.notReachable.rawValue
            || NetworkStatus.rawValue == LKNetworkStatus.unknown.rawValue {
            DLog("无网络")
        }else {
            manager.request(lastUrl ,
                            method: httpMethod,
                            parameters: params,
                            encoding:URLEncoding.httpBody,
                            headers:HTTPHeaders.init(httpHeaders!)).responseJSON{ (response) in
                                switch response.result {
                                case .success(let value):
                                    DLog("接口路径：" + lastUrl )
//                                    DLog(JSON(value))
                                    success(APIResultModel.deserialize(from:value as? Dictionary) ?? APIResultModel())
                                    return
                                case .failure(let error):
                                    DLog(String(describing: error))
                                    fail(String(describing: error))
                                    return
                                }}
        }
        
    }
}


// MARK: 网络状态相关
extension LKNetworkManager {
    ///监听网络状态
    public func detectNetwork(netWorkStatus: @escaping LKNetworkStatusBlock) {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening(onUpdatePerforming: {  [weak self] (status) in
            guard let weakSelf = self else { return }
            if reachability?.isReachable ?? false {
                switch status {
                case .notReachable:
                    weakSelf.NetworkStatus = LKNetworkStatus.notReachable
                case .unknown:
                    weakSelf.NetworkStatus = LKNetworkStatus.unknown
                case .reachable(.cellular):
                    weakSelf.NetworkStatus = LKNetworkStatus.cellular
                case .reachable(.ethernetOrWiFi):
                    weakSelf.NetworkStatus = LKNetworkStatus.wifi
                }
            } else {
                weakSelf.NetworkStatus = LKNetworkStatus.notReachable
            }
            netWorkStatus(weakSelf.NetworkStatus.rawValue)
        })
    }
    ///监听网络状态
    public func obtainDataFromLocalWhenNetworkUnconnected() {
        let cellularData = CTCellularData.init()
        cellularData.cellularDataRestrictionDidUpdateNotifier = {
            (state)in
            switch state {
            case .restricted:
                DLog("拒绝使用网络")
                break
            case .notRestricted:
                DLog("允许使用网络")
                break
            case .restrictedStateUnknown:
                DLog("未知网络错误")
                break
            default:
                break
            }
        }
        self.detectNetwork { (networkStatus) in
            var status = "WIFI"
            switch networkStatus {
            case LKNetworkStatus.unknown.rawValue:
                status = "未知网络"
                break
            case LKNetworkStatus.notReachable.rawValue:
                status = "网络无连接"
                break
            case LKNetworkStatus.cellular.rawValue:
                status = "蜂窝网"
                break
            default:
                status = "WIFI"
                break
            }
            DLog(status)
        }
    }
}

// MARK: url拼接相关
extension LKNetworkManager {
    /// 更新baseURL
    public func updateBaseUrl(baseUrl: String) {
        privateNetworkBaseUrl = baseUrl
    }
    /// 获取baseURL
    public func baseUrl() -> String? {
        return privateNetworkBaseUrl
    }
    ///中文路径encoding
    public func encodingURL(path: String) -> String {
        return path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    ///拼接baseurl生成完整url
    public func absoluteUrlWithPath(path: String?) -> String {
        if path == nil
            || path?.length == 0 {
            return ""
        }
        if self.baseUrl() == nil
            || self.baseUrl()?.length == 0 {
            return path!
        }
        var absoluteUrl = path
        if !(path?.hasPrefix("http://"))!
            && !(path?.hasPrefix("https://"))! {
            if (self.baseUrl()?.hasPrefix("/"))! {
                if (path?.hasPrefix("/"))! {
                    var mutablePath = path
                    mutablePath?.remove(at: (path?.startIndex)!)
                    absoluteUrl = self.baseUrl()! + mutablePath!
                } else {
                    absoluteUrl = self.baseUrl()! + path!
                }
            } else {
                if (path?.hasPrefix("/"))! {
                    absoluteUrl = self.baseUrl()! + path!
                } else {
                    absoluteUrl = self.baseUrl()! + "/" + path!
                }
            }
        }
        return absoluteUrl!
    }
    /// 在url最后添加一部分,这里是添加的选择语言,可以根据需求修改.
    public func buildAPIString(path: String) -> String {
        if path.containsIgnoringCase(find: "http://")
            || path.containsIgnoringCase(find: "https://") {
            return path
        }
        let lang = "zh_CN"
        var str = ""
        if path.containsIgnoringCase(find: "?") {
            str = path + "&@lang=" + lang
        } else {
            str = path + "?@lang=" + lang
        }
        return str
    }
    /// get请求下把参数拼接到url上
    public func generateGETAbsoluteURL(url: String, _ params: [String: Any]?) -> String {
        guard let params = params else {return url}
        if params.count == EMPTY {
            return url
        }
        var url = url
        var queries = ""
        for key in (params.keys) {
            let value = params[key]
            if value is [String: Any] {
                continue
            } else if value is [Any] {
                continue
            } else if value is Set<AnyHashable> {
                continue
            } else {
                queries = queries.length == 0 ? "&" : queries + key + "=" + "\(value as? String ?? "")"
            }
        }
        if queries.length > 1 {
            queries = String(queries[queries.startIndex..<queries.endIndex])
        }
        if (url.hasPrefix("http://")
            || url.hasPrefix("https://")
            && queries.length > 1) {
            if url.containsIgnoringCase(find: "?")
                || url.containsIgnoringCase(find: "#") {
                url = "\(url)\(queries)"
            } else {
                queries = queries.stringCutToEnd(star: 1)
                url = "\(url)?\(queries)"
            }
        }
        return url.length == 0 ? queries : url
    }
}
