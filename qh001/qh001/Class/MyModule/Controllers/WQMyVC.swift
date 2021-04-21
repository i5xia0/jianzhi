//
//  WQMyVC.swift
//
//
//  Created by linke50 on 7/17/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit


private let myCell_id = "myCell"
private let switchCell_id = "switchCell"

class WQMyVC: WQBaseVC {
    
    private let userInfo = [["image":UIImage.iconfont(text: "\u{e69a}", size: 20,color: COLOR_Base.SEAB300),
                            "title":"我的自选",
                            "subTitle": nil] as [String : Any?],
                            ["image":UIImage.iconfont(text: "\u{e6cf}", size: 20,color: COLOR_Base.SEAB300),
                            "title":"我的关注",
                            "subTitle": nil] as [String : Any?],
                            ["image":UIImage.iconfont(text: "\u{e6c4}", size: 20,color: COLOR_Base.SEAB300),
                            "title":"我的收藏",
                            "subTitle": nil] as [String : Any?]]
    private var moneySet = [["image":UIImage.iconfont(text: "\u{e63c}", size: 20,color: COLOR_Base.SEAB300) as Any,
                             "title":"联系客服",
                             "subTitle":"BSV"],
                            ["image":UIImage.iconfont(text: "\u{e724}", size: 20,color: COLOR_Base.SEAB300) as Any,
                             "title":"意见反馈",
                             "subTitle":"CNY"],
                            ["image":UIImage.iconfont(text: "\u{e65b}", size: 20,color: COLOR_Base.SEAB300) as Any,
                             "title":"版本更新",
                             "subTitle": ""]] as [Any]
    private let paySet = ["image":UIImage.iconfont(text: "\u{e60b}", size: 20,color: UIColor.red) as Any,
                          "title": "退出登录"] as [String : Any]
    
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib.init(nibName: "SPMyCell", bundle: Bundle.main), forCellReuseIdentifier: myCell_id)
        tableView.register(UINib.init(nibName: "SPSwitchCell", bundle: Bundle.main), forCellReuseIdentifier: switchCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    
    lazy var headerView: WQMyHeaderView = {
        let headView = WQMyHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: SafeAreaTopHeight + 160))
        headView.nameBtn.addTarget(self, action: #selector(loginOrRegister), for: UIControl.Event.touchUpInside)
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *)  {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
        }
        getUserInfo()
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(login), name:NSNotification.Name.login, object: nil)
    }
    func getUserInfo() {
        if UserTool.shared.isLogin {
            LKNetworkManager.shared.getInfo { (result) -> (Void) in
               print(result)
            } fail: { (error) -> (Void) in
                WQProgressHUD.showMassage(error)
            }

        }
    }
    func updateUI() {
        self.tableView.reloadData()
        self.headerView.avatarView.image = UIImage(named: "img_photo_default")
        self.headerView.nameBtn.setTitle(UserTool.shared.isLogin ? UserTool.shared.userName : "登录/注册", for: UIControl.State.normal)
    }
    @objc dynamic func loginOrRegister()  {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
        }
    }
    @objc
    func login(noti: Notification) {
        //获取用户数据
        updateUI()
    }
    //出现内存警告时
    override func didReceiveMemoryWarning() {
         //移除通知
         NotificationCenter.default.removeObserver(self)
     }
    
    
}
extension WQMyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  UserTool.shared.isLogin ? 4 : 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else if section == 1{
            return 3
        }else if section == 2 {
            return  UserTool.shared.isLogin ? 1 : 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 60
        }
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: myCell_id, for: indexPath) as! SPMyCell
        if (indexPath.section != 2) {
            
            if (indexPath.section == 0 ) {
                let set = userInfo[indexPath.row] as [NSString:Any]
                myCell.imageView?.image = (set["image"] as! UIImage)
                myCell.textLabel?.text = (set["title"] as! String)
                myCell.detailTextLabel?.text = nil
            } else if (indexPath.section == 1) {
                let set = moneySet[indexPath.row] as! [NSString:Any]
                myCell.imageView?.image = (set["image"] as! UIImage)
                myCell.textLabel?.text = (set["title"] as! String)
                myCell.detailTextLabel?.text = nil
            }
            return myCell
        }else {
            myCell.imageView?.image = (paySet["image"] as! UIImage)
            myCell.textLabel?.text = (paySet["title"] as! String)
            myCell.detailTextLabel?.text = nil
            return myCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 2 {
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.section == 0 {
                if !UserTool.shared.isLogin {
                    NavigationManager.shared.goToLogin()
                }
            }else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    if !UserTool.shared.isLogin {
                        NavigationManager.shared.goToLogin()
                    }
                    NavigationManager.shared.goToServiceChat()
                }else if indexPath.row == 1 {
                    if !UserTool.shared.isLogin {
                        NavigationManager.shared.goToLogin()
                    }
                    NavigationManager.shared.goToFeedback()
                }else {
                    WQProgressHUD.showMassage("您当前版本为最新版本")
                }
            }
        }else {
            tableView.deselectRow(at: indexPath, animated: false)
            let alertController = UIAlertController.init(title: "提示", message: "确定退出登录吗？", preferredStyle: .alert);
            alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            }))
            alertController.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
                UserTool.shared.logout()
                self.updateUI()
            }))
            self.present(alertController, animated: true) 
        }
    }
}
