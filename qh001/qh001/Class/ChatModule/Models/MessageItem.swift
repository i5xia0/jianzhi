//
//  MessageItem.swift
//  ShowPay
//
//  Created by linke50 on 7/29/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit

/*
 消息类型
 */
enum MessageType {
    case text
    case pay
    case image
}
/*
 消息发送方
 */
enum UserType {
    case mine
    case someone
}
/*
 消息发送状态
 */
enum SentStatus {
    case sended  //送达
    case unSended  //未送达
    case sending //正在送达
}
/*
 消息接收状态
 */
enum ReadStatus {
    case read  //已读
    case unRead //未读
}
//支付类型 
enum PayType {
    case stateless
    case transfer  //转账
    case like      //点赞
    case follow    //关注
    case comments  //评论
}

class MessageItem {
    //用户信息
    var user: SPUserInfo
    //消息时间
    var date: Date
    //用户类型
    var userType: UserType
    //消息类型
    var messageType: MessageType
    //支付类型
    var payType: PayType
    //内容视图
    var view:UIView
    //发送转态
    var sentStatus: SentStatus
    
    //设置我的文本消息边距
    class func getTextInsetsMine() -> UIEdgeInsets {
        return UIEdgeInsets(top:12, left:20, bottom:12, right:20)
    }
    
    //设置他人的文本消息边距
    class func getTextInsetsSomeone() -> UIEdgeInsets {
        return UIEdgeInsets(top:12, left:20, bottom:12, right:20)
    }
    //设置我的图片消息边距
    class func getImageInsetsMine() -> UIEdgeInsets {
        return UIEdgeInsets(top:9, left:10, bottom:9, right:17)
    }
    
    //设置他人的图片消息边距
    class func getImageInsetsSomeone() -> UIEdgeInsets {
        return UIEdgeInsets(top:9, left:15, bottom:9, right:10)
    }
    
    //可以传入更多自定义视图
    init(user: SPUserInfo,userType: UserType, messageType: MessageType, payType: PayType, date: Date, view:UIView, sentStatus:SentStatus) {
        self.user = user
        self.date = date
        self.userType = userType
        self.messageType = messageType
        self.payType = payType
        self.view = view
        self.sentStatus = sentStatus
    }
    //构造文本消息体
    convenience init(body:String, user:SPUserInfo, date:Date, utype:UserType,sentStatus:SentStatus) {
        let customView = UIView()
        let textView = UIView()
        let font =  SFONT.PingFang12
        let width =  225, height = 10000.0
        let atts =  [NSAttributedString.Key.font: font]
        let size =  body.boundingRect(with:
            CGSize(width: CGFloat(width), height: CGFloat(height)),
                                      options: .usesLineFragmentOrigin, attributes:atts as [NSAttributedString.Key : Any], context:nil)
        let label =  UILabel(frame:CGRect(x: 20, y: 12, width: size.size.width,
                                          height: size.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = (body.length != 0 ? body as String : "")
        label.font = font
        label.textColor = (utype == UserType.mine ?
        COLOR_Base.SFFFFFF : COLOR_Base.S303133 )
        textView.addSubview(label)
        textView.frame = CGRect(x: 0, y: 0, width: size.size.width + 40,
                                height: size.size.height + 24)
        textView.cornerAll(20)
        textView.layer.backgroundColor = (utype == UserType.someone ?
            COLOR_Base.SFFFFFF.cgColor : COLOR_Base.S617FFF.cgColor )
        customView.addSubview(textView)
        if sentStatus == SentStatus.sended {
            customView.frame = CGRect(x: 0, y: 0, width: size.size.width + 40,height: size.size.height + 24)
        }else if sentStatus == SentStatus.unSended {
            textView.layer.backgroundColor = COLOR_Base.SBFC2CC.cgColor
            let sendLabel = UILabel()
            let attrString = NSMutableAttributedString(string: "发送失败 请重试")
            let attr: [NSAttributedString.Key : Any] = [.font: SFONT.PingFang10 as Any,.foregroundColor: UIColor(red: 0.38, green: 0.5, blue: 1,alpha:1), ]
            attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
            let strSubAttr1: [NSMutableAttributedString.Key: Any] = [.font: SFONT.PingFang10 as Any,.foregroundColor: UIColor(red: 0.75, green: 0.76, blue: 0.8,alpha:1)]
            attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: 5))
            let strSubAttr2: [NSMutableAttributedString.Key: Any] = [.font: SFONT.PingFang10 as Any,.foregroundColor: UIColor(red: 0.38, green: 0.5, blue: 1,alpha:1)]
            attrString.addAttributes(strSubAttr2, range: NSRange(location: 5, length: 3))
            sendLabel.attributedText = attrString
            customView.addSubview(sendLabel)
            sendLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(textView.snp.bottom).offset(6)
                make.width.equalTo(74)
                make.height.equalTo(14)
            }
            customView.frame = CGRect(x: 0, y: 0, width: size.size.width + 40,height: size.size.height + 44)
        }
        self.init(user:user, userType:utype,messageType: MessageType.text, payType: PayType.stateless, date:date, view:customView, sentStatus:sentStatus)
    }
    //构造支付消息体
    convenience init(pay: UInt64,payBody:String, user:SPUserInfo,  payType: PayType, date:Date, utype:UserType) {
        let customView = UIView()
        let payView = UIView(frame: CGRect(x: 0, y: 0, width: 208, height: 84))
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 208, height: 62))
        if payType == PayType.transfer { //转账
            topView.layer.backgroundColor = COLOR_Base.SEAB300.cgColor
            let currencyLabel = UILabel(frame: CGRect(x: 20, y: 12, width: 168, height: 28))
            currencyLabel.font = SFONT.PingFang20
            currencyLabel.textColor = .white
            currencyLabel.text = "22.35 USD"
            topView.addSubview(currencyLabel)
            let virtualCoinLabel = UILabel(frame: CGRect(x: 20, y: 36, width: 168, height: 14))
            virtualCoinLabel.font = SFONT.PingFang10
            virtualCoinLabel.textColor = .white
            virtualCoinLabel.text = "≈0.085 BSV"
            topView.addSubview(virtualCoinLabel)
        }else {
            let imageView = UIImageView()
            topView.addSubview(imageView)
            imageView.contentMode = .center
            imageView.snp.makeConstraints { (make) in
                make.width.height.equalTo(21)
                make.top.equalToSuperview().offset(11)
                make.centerX.equalToSuperview()
            }
            let SATLabel = UILabel()
            SATLabel.font = SFONT.PingFang10
            SATLabel.textColor = .white
            SATLabel.textAlignment = .center
            SATLabel.text = "\(pay) SAT"
            topView.addSubview(SATLabel)
            SATLabel.sizeToFit()
            SATLabel.snp.makeConstraints { (make) in
                make.width.equalTo(SATLabel)
                make.height.equalTo(SATLabel)
                make.top.equalTo(imageView.snp.bottom).offset(5)
                make.centerX.equalToSuperview()
            }
            if payType == PayType.like { //点赞
                topView.layer.backgroundColor = COLOR_Base.SFC6D5E.cgColor
                imageView.image = #imageLiteral(resourceName: "pay_like")
            }else if payType == PayType.comments { //评论
                topView.layer.backgroundColor = COLOR_Base.S2FC78C.cgColor
                imageView.image = #imageLiteral(resourceName: "pay_comment")
            }else if payType == PayType.follow { //关注
                topView.layer.backgroundColor = COLOR_Base.S509EFF.cgColor
                imageView.image = #imageLiteral(resourceName: "pay_follow")
            }
        }
        topView.cornerAll(20)
        payView.addSubview(topView)
        let bottomView = UIView(frame: CGRect(x: 0, y: 62, width: 208, height: 22))
        let appLogo = UIImageView(image: #imageLiteral(resourceName: "logo_ShowBuzz"))
        appLogo.frame = CGRect(x: 20, y: 5, width: 12, height: 12)
        bottomView.addSubview(appLogo)
        let appName = UILabel(frame: CGRect(x: 36, y: 0, width: 120, height: 22))
        appName.text = "ShowBuzz"
        appName.textColor = COLOR_Base.SBFC2CC
        appName.font = SFONT.PingFang08
        bottomView.addSubview(appName)
        payView.addSubview(bottomView)
        payView.cornerAll(20)
        payView.layer.backgroundColor = UIColor.white.cgColor
        customView.addSubview(payView)
        customView.frame = CGRect(x: 0, y: 0, width: 208,height: 84)
        if payBody.length != 0 {
            let textView = UIView()
            let font =  SFONT.PingFang10
            let width =  168, height = 28
            let atts =  [NSAttributedString.Key.font: font]
            let size =  payBody.boundingRect(with:
                CGSize(width: CGFloat(width), height: CGFloat(height)),
                                          options: .usesLineFragmentOrigin, attributes:atts as [NSAttributedString.Key : Any], context:nil)
            let label =  UILabel(frame:CGRect(x: 20, y: 12, width: size.size.width,
                                              height: size.size.height))
            label.numberOfLines = 2
            label.text = (payBody.length != 0 ? payBody as String : "")
            label.font = font
            label.textColor = COLOR_Base.S909399
            textView.addSubview(label)
            textView.frame = CGRect(x: 0, y: 89, width: size.size.height > 14 ? 208 : size.size.width + 40,
                                    height: size.size.height + 24)
            textView.cornerAll(20)
            textView.layer.backgroundColor =  COLOR_Base.SEDEFF2.cgColor
            customView.addSubview(textView)
            customView.frame = CGRect(x: 0, y: 0, width: 208,height: size.size.height + 113)
        }
        self.init(user:user,  userType:utype, messageType: MessageType.pay, payType: payType,date:date, view:customView, sentStatus:SentStatus.sended)
    }
    //构造图片消息体
    convenience init(image:UIImage, user:SPUserInfo,  date:Date, utype:UserType) {
        var size = image.size
        //等比缩放
        if (size.width > 220) {
            size.height /= (size.width / 220);
            size.width = 220;
        }
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: size.width,
                                                 height: size.height))
        imageView.image = image
        imageView.cornerAll(5)
        self.init(user:user,  userType:utype,messageType: MessageType.image, payType: PayType.stateless, date:date, view:imageView, sentStatus:SentStatus.sended)
    }
}
