//
//  WQAPIMacro.swift
//  qh
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

#if DEBUG


let API_BASE = "https://fhqh.fckqh.top/api"


#else


let API_BASE = "https://fhqh.fckqh.top/api"

#endif

//API接口URL路径
struct API_Path {
    //注册
    static let register =  "/user/register"
    //登录
    static let login =  "/user/login"
    //获取用户数据
    static let getInfo = "/user/getinfo"
    
    
    //上期所 数据
    static let mainContract =  "/features/mainContract"
    //上期所 k线数据
    static let contractLine =  "/features/kLine"
    //微视频
    static let video =  "/commondata/videolist"
    //快讯 newsflash
    static let newsflash =  "/commondata/newsflashlist"
    //新闻 newsflash
    static let news =  "/commondata/newslist"
    //bss
    static let BSSList =  "/commondata/bsslist"
}

