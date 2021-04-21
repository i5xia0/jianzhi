//
//  SPChatVC.swift
//  ShowPay
//
//  Created by linke50 on 7/28/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


private let contactsCell_id = "contactsCell"

class SPChatVC: WQBaseVC {
    
    
    var myFriend: SPFriendModel!
    
    lazy var chatNavBar: WQCustomNavBar = {
        let navBar = WQCustomNavBar.customView()
        navBar.frame =   CGRect(x: 0, y: 0, width: ScreenWidth, height: NavgationHeight)
        navBar.backgroundColor = .white
        navBar.title = self.title ?? ""
        navBar.leftBtn.addTarget(self, action: #selector(leftBtnClick), for: UIControl.Event.touchUpInside)
        view.addSubview(navBar)
        return navBar
    }()
    var Chats:NSMutableArray! = NSMutableArray()
    var me:SPUserInfo!
    var you:SPUserInfo!
    
    lazy var tableView:SPChatTableView = {
        let tableView = SPChatTableView(frame:CGRect(x: 0, y: NavgationHeight, width: ScreenWidth, height: ScreenHeight - 50 - SafeAreaBottomHeight - NavgationHeight), style: .plain)
        if #available(iOS 11.0, *)  {
           tableView.contentInsetAdjustmentBehavior = .never
        } else {

        }
        //set the chatDataSource
        tableView.chatDataSource = self
        //创建一个重用的单元格
        tableView.register(SPChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
        return tableView
    }()
    
    lazy var chatFooterBar: UIView = {
        let chatFooterBar = SPChatFooterBar(frame: CGRect(x: 0, y: ScreenHeight - 50 - SafeAreaBottomHeight, width: ScreenWidth, height: 50))
        chatFooterBar.backgroundColor = .white
        chatFooterBar.footerBarDelegate = self
        return chatFooterBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(SPChatVC.keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         IQKeyboardManager.shared.enable = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func loadData() {
        
    }
    var localArray:Array<SPMessageModel> = Array()
    var dataArray:Array<SPMessageModel> = Array()
    var msgDic = Dictionary<String,Int>()
    func updateText() {
        for message in self.dataArray {
            
        }
        setupData(self.dataArray)
    }
    func setupData(_ array: Array<SPMessageModel>) {
        self.Chats.removeAllObjects()
//        me = SPUserInfo(name:UserTool.shared.user.userName ?? "" ,logo:UserTool.shared.user.headUrl ?? "")
//        you  = SPUserInfo(name:myFriend.name!, logo:myFriend.avatar!)
        tableView.reloadData()
    }
    
    @objc private func keyboardWillChangeFrame(node : Notification){     
        //1.获取动画执行的时间
        let duration =  node.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        //2. 获取键盘最终的Y值
        let endFrame = (node.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        //4.执行动画
        chatFooterBar.bottomY = y > (ScreenHeight - SafeAreaBottomHeight) ? (ScreenHeight - SafeAreaBottomHeight) : y
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.tableView.scrollToBottom(y > (ScreenHeight - SafeAreaBottomHeight))
        }
    }
    
    
    
}
extension SPChatVC {
    @objc
    func messageDecrypt(noti: Notification) {
        let decryptMsg = noti.userInfo!["decrypt"] as! String
        for key in msgDic.keys {
            if decryptMsg.contains(key) {
                let model = self.dataArray[msgDic[key]!]
                self.dataArray[msgDic[key]!] = model
                self.setupData(self.dataArray)
                //存入数据库
                
            }
        }
    }
    //MARK: 布局视图
    func setupView() {
        chatNavBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(NavgationHeight)
        }
        view.addSubview(tableView)
        view.addSubview(chatFooterBar)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(chatNavBar.snp.bottom)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(ScreenHeight - 50 - SafeAreaBottomHeight - NavgationHeight)
            make.bottom.equalTo(chatFooterBar.snp.top)
        }
        
    }
}
extension SPChatVC: FooterBarDelegate {
    func sendTransfer(_ money: Double) {
        
    }
    
    
    func sendMessage(_ message: String) {
        let meModel = SPUserInfo.init(name: "lin", logo: "img_photo_default")
        let thisChat =  MessageItem(body:message, user:meModel, date:Date(), utype:UserType.mine, sentStatus: SentStatus.sended)
        Chats.add(thisChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
    }
}

extension SPChatVC: ChatDataSource {
    func rowsForChatTable(_ tableView:SPChatTableView) -> Int
    {
        return self.Chats.count
    }
    
    func chatTableView(_ tableView:SPChatTableView, dataForRow row:Int) -> MessageItem
    {
        
        return Chats[row] as! MessageItem
    }
}
