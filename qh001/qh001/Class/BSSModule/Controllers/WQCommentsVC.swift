//
//  WQCommentsVC.swift
//  qh001
//
//  Created by linke50 on 4/16/21.
//

import UIKit
import IQKeyboardManagerSwift

private let commentsTopCell_id = "commentsTopCell"
private let commentsCell_id = "commentsCell"



protocol CommentsDelegate {
    func updateBSSData(_ model:WQBSSModel)-> Void
}

class WQCommentsVC: WQBaseVC {

    
    var delegate: CommentsDelegate!
    var model: WQBSSModel!
        
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
//        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQCommentsTopCell", bundle: Bundle.main), forCellReuseIdentifier: commentsTopCell_id)
        tableView.register(UINib.init(nibName: "WQCommentsCell", bundle: Bundle.main), forCellReuseIdentifier: commentsCell_id)
        view.addSubview(tableView)
        return tableView
    }()

    lazy var titleView: UIView = {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        view.backgroundColor = .white
        let label = UILabel()
        label.font = SFONT.Bold12
        label.text = "全部评论"
        titleView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        return titleView
    }()
    
    lazy var promptView: UIView = {
        let promptView = UIView()
        let label = UILabel()
        label.font = SFONT.PingFang12
        label.numberOfLines = 0
        label.text = "声明：用户在社区发表的所有资料，言论仅代表个人观点，与本平台的立场无关，据此操作，风险自担。\n提示：严禁发布色情、政治敏感词、赌博等违法文字，一经发现，立刻封号！"
        promptView.addSubview(label)
        label.textColor = COLOR_Base.S303133
        label.width = ScreenWidth - 40
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 5, width: ScreenWidth - 40, height: label.height)
        promptView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: label.height + 10)
        return promptView
    }()
    
    lazy var chatFooterBar: UIView = {
        let chatFooterBar = SPChatFooterBar(frame: CGRect(x: 0, y: ScreenHeight - 50 - SafeAreaBottomHeight, width: ScreenWidth, height: 50))
        chatFooterBar.backgroundColor = .white
        chatFooterBar.footerBarDelegate = self
        return chatFooterBar
    }()
    
    var comments = Array<WQCommentModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = "详情"
        navBarReturn = true
        
        self.comments = UserTool.shared.comments[model.id!] ?? Array()
        
        view.addSubview(chatFooterBar)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(chatFooterBar.snp.top)
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = promptView
        
        NotificationCenter.default.addObserver(self, selector: #selector(WQCommentsVC.keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
       
        
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
    @objc private func keyboardWillChangeFrame(node : Notification){
        //2. 获取键盘最终的Y值
        let endFrame = (node.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        //4.执行动画
        chatFooterBar.bottomY = y > (ScreenHeight - SafeAreaBottomHeight) ? (ScreenHeight - SafeAreaBottomHeight) : y
    }
    
    @objc dynamic func likeBtnClick(sender:UIButton) {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
            return
        }
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            model.like = 1
            WQProgressHUD.showMassage("点赞成功")
            sender.setTitle(" \(model.like)", for: UIControl.State.normal)
        }else {
            model.like = 0
            WQProgressHUD.showMassage("取消点赞")
            sender.setTitle("", for: UIControl.State.normal)
        }
        delegate.updateBSSData(model)
    }
    @objc dynamic func moreBtnClick() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet);
        alertController.addAction(UIAlertAction.init(title: "拉黑", style: .destructive, handler: { (action) in
        }))
        alertController.addAction(UIAlertAction.init(title: "举报", style: .destructive, handler: { (action) in
        }))
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
        }))
        self.present(alertController, animated: true)
    }

}
extension WQCommentsVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comments.count > 0 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.comments.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return titleView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 1 {
            view.backgroundColor = .white
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: commentsTopCell_id, for: indexPath) as! WQCommentsTopCell
            cell.setData(model: model)
            cell.likeBtn.addTarget(self, action: #selector(likeBtnClick), for: UIControl.Event.touchUpInside)
            cell.moreBtn.addTarget(self, action: #selector(moreBtnClick), for: UIControl.Event.touchUpInside)
            return cell
        }else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: commentsCell_id, for: indexPath) as! WQCommentsCell
            cell.setData(model: self.comments[indexPath.row])
            return cell

        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension WQCommentsVC: FooterBarDelegate {
    func sendTransfer(_ money: Double) {
        
    }
    
    
    func sendMessage(_ message: String) {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
            return
        }
        WQProgressHUD.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage("评论成功")
        }
        let comment = WQCommentModel.init()
        comment.avatars = "img_photo_default"
        comment.name = UserTool.shared.userName
        comment.content = message
        let value = Date()
        var timeInterval = value.timeIntervalSinceNow
        let dateFormatter =  DateFormatter()
        timeInterval = -timeInterval
        if timeInterval/60 > 60 {
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        }else {
            dateFormatter.dateFormat = "HH:mm"
        }
        comment.timestamp =  dateFormatter.string(from: value)
        self.comments.append(comment)
        UserTool.shared.comments = [model.id!:self.comments]
        self.tableView.reloadData()
    }
}
