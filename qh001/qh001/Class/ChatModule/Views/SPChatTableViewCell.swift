//
//  SPChatTableViewCell.swift
//  ShowPay
//
//  Created by linke50 on 7/29/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPChatTableViewCell:UITableViewCell {
    //消息内容视图
    var customView: UIView!
    //左侧头像
    lazy var leftAvatarImage: UIImageView = {
        let leftImage = UIImageView(frame: CGRect(x: 20, y: 0, width: 40, height: 40))
        leftImage.image = UIImage(named: "img_photo_default")
        return leftImage
    }()
    //右侧头像
    lazy var rightAvatarImage: UIImageView = {
        let rightImage = UIImageView(frame: CGRect(x: self.frame.size.width - 60, y: 0, width: 40, height: 40))
        rightImage.image = UIImage(named: "img_photo_default")
        return rightImage
    }()
    //左侧对话框箭头
    lazy var leftArrow: UILabel = {
        let left = UILabel(frame: CGRect(x:65, y: 15, width: 15, height: 12))
        left.font =  UIFont.showicon(ofSize: 12)
        left.text = "\u{e61d}"
        left.textColor = COLOR_Base.SFFFFFF
        left.transform = CGAffineTransform(rotationAngle: CGFloat(110*Double.pi/180))
        return left
    }()
    //右侧对话框箭头
    lazy var rightArrow: UILabel = {
        let right = UILabel(frame: CGRect(x:self.frame.size.width - 80, y: 15, width: 15, height: 12))
        right.font =  UIFont.showicon(ofSize: 12)
        right.text = "\u{e61f}"
        right.textColor = COLOR_Base.S617FFF
        right.transform = CGAffineTransform(rotationAngle: CGFloat(-110*Double.pi/180))
        return right
    }()
    //消息数据结构
    var msgItem:MessageItem!
    
   
    init(data:MessageItem, reuseIdentifier cellId:String) {
        self.msgItem = data
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier:cellId)
        rebuildUserInterface()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func rebuildUserInterface() {
        self.backgroundColor = COLOR_Base.SF5F7FA
               self.selectionStyle = UITableViewCell.SelectionStyle.none
               self.addSubview(leftAvatarImage)
               self.leftAvatarImage.cornerAll(20)
               self.addSubview(rightAvatarImage)
               self.rightAvatarImage.cornerAll(20)
               self.addSubview(leftArrow)
               self.addSubview(rightArrow)
        if self.msgItem.userType == UserType.mine {
            leftAvatarImage.isHidden = true
            leftArrow.isHidden = true
            rightAvatarImage.isHidden = false
            rightArrow.isHidden = false
        }else {
            leftAvatarImage.isHidden = false
            leftArrow.isHidden = false
            rightAvatarImage.isHidden = true
            rightArrow.isHidden = true
        }
        //显示用户头像
//        if (self.msgItem.user.username != "")
//        {
//
//            let thisUser =  self.msgItem.user
//            self.msgItem.userType != UserType.mine ? () : )
//        }
        if self.msgItem.messageType == .text {
            leftArrow.textColor = COLOR_Base.SFFFFFF
            if self.msgItem.sentStatus == .unSended {
                rightArrow.textColor = COLOR_Base.SBFC2CC
            }else {
                rightArrow.textColor = COLOR_Base.S617FFF
            }
        }else if self.msgItem.messageType == .pay {
            var color = COLOR_Base.SEAB300
            switch self.msgItem.payType {
            case .transfer:
                color = COLOR_Base.SEAB300
                break
            case .like:
                color = COLOR_Base.SFC6D5E
                break
            case .comments:
                color = COLOR_Base.S2FC78C
                break
            case .follow:
                color = COLOR_Base.S509EFF
                break
            default:
                break
            }
            leftArrow.textColor = color
            rightArrow.textColor = color
        }
        let type =  self.msgItem.userType
        let width =  self.msgItem.view.frame.size.width
        let height =  self.msgItem.view.frame.size.height
        var x =  (type == UserType.someone) ? 0 : self.frame.size.width - width
        let y:CGFloat =  10
        if (type == UserType.someone) {
            x += 74
        }
        if (type == UserType.mine) {
            x -= 74
        }
        self.customView = self.msgItem.view
        self.customView.frame = CGRect(x: x,
                                       y: y, width: width, height: height)
        self.addSubview(self.customView)
        
    }
    
    //让单元格宽度始终为屏幕宽
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.width = UIScreen.main.bounds.width
            super.frame = frame
        }
    }
}
