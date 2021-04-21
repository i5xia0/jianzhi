//
//  WQBSSVC.swift
//  qh001
//
//  Created by linke50 on 4/7/21.
//

import UIKit
import MJRefresh

private let BSSCell_id = "BSSCell"

class WQBSSVC: WQBaseVC {

//    lazy var titlesView: UIView = {
//        let titlesView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
//        titlesView.backgroundColor = .white
//        titlesView.border([.top,.bottom], COLOR_Base.SF5F7FA, 1.0)
//        let nameCodeLab = UILabel()
//        nameCodeLab.font = SFONT.PingFang12
//        nameCodeLab.textAlignment = .center
//        nameCodeLab.text = "最新"
//        titlesView.addSubview(nameCodeLab)
//        nameCodeLab.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(ScreenWidth/3)
//        }
//        let nowVLab = UILabel()
//        nowVLab.font = SFONT.PingFang12
//        nowVLab.textAlignment = .center
//        nowVLab.text = "热门"
//        titlesView.addSubview(nowVLab)
//        nowVLab.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.equalTo(nameCodeLab.snp.right)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(ScreenWidth/3)
//        }
//        let upDownRateLab = UILabel()
//        upDownRateLab.font = SFONT.PingFang12
//        upDownRateLab.textAlignment = .center
//        upDownRateLab.text = "讨论"
//        titlesView.addSubview(upDownRateLab)
//        upDownRateLab.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.equalTo(nowVLab.snp.right)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(ScreenWidth/3)
//        }
//        view.addSubview(titlesView)
//        return titlesView
//    }()
    
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQBSSCell", bundle: Bundle.main), forCellReuseIdentifier: BSSCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    
    
    var datas: Array = Array<WQBSSModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = "期货论坛"
        navBarReturn = false
        navBar.rightBtn.setImage(UIImage.iconfont(text: "\u{e625}", size: 15), for: UIControl.State.normal)
        navBar.rightBtn.addTarget(self, action: #selector(rightBtn), for: UIControl.Event.touchUpInside)
//        titlesView.snp.makeConstraints { make in
//            make.top.equalTo(navBar.snp.bottom)
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(40)
//        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        tableView.mj_header?.beginRefreshing()
    }
    
    @objc dynamic func headerRefresh(){
        LKNetworkManager.shared.getBSSList { (result) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            let list:Array<Any> = result.data as! Array<Any>
            let arr:Array<WQBSSModel> = list.map{WQBSSModel.deserialize(from: ($0 as! Dictionary<String,Any>))!}
            for model in arr  {
                if UserTool.shared.likes.count > 0 && UserTool.shared.likes.allSatisfy({$0==model.id}) {
                    model.like = 1
                }
                if UserTool.shared.shielding.count > 0 && UserTool.shared.shielding.allSatisfy({$0==model.id}) {
                    
                }else {
                    self.datas.append(model)
                }
               
            }
            self.tableView.reloadData()
        } fail: { (error) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            WQProgressHUD.showMassage(error)
        }
    }
    
    @objc dynamic func rightBtn() {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
            return
        }
        NavigationManager.shared.presentPostVC()
    }
    @objc dynamic func likeBtnClick(sender:UIButton) {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
            return
        }
        sender.isSelected = !sender.isSelected
        let model = self.datas[sender.tag - 20]
        if sender.isSelected {
            model.like = 1
            WQProgressHUD.showMassage("点赞成功")
            sender.setTitle(" \(model.like)", for: UIControl.State.normal)
        }else {
            model.like = 0
            WQProgressHUD.showMassage("取消点赞")
            sender.setTitle("", for: UIControl.State.normal)
        }
        if model.like > 1 {
            UserTool.shared.likes.append(model.id!)
        }else {
            UserTool.shared.likes.removeAll{ $0 == model.id }
        }
        self.datas[sender.tag - 20] = model
    }
    @objc dynamic func commentBtnClick(sender:UIButton) {
        if !UserTool.shared.isLogin {
            NavigationManager.shared.goToLogin()
            return
        }
        NavigationManager.shared.goToCommentsVC(model: self.datas[sender.tag], bssVC: self)
    }
    @objc dynamic func moreBtnClick(sender:UIButton) {
        let index = sender.tag - 60
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet);
        alertController.addAction(UIAlertAction.init(title: "拉黑", style: .destructive, handler: { (action) in
            if !UserTool.shared.isLogin {
                NavigationManager.shared.goToLogin()
                return
            }
            UserTool.shared.shielding.append(index)
            self.datas.remove(at: index)
            self.tableView.reloadData()
            WQProgressHUD.showMassage("拉黑成功！将不再展示此消息")
        }))
        alertController.addAction(UIAlertAction.init(title: "举报", style: .destructive, handler: { (action) in
            if !UserTool.shared.isLogin {
                NavigationManager.shared.goToLogin()
                return
            }
            WQProgressHUD.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                WQProgressHUD.hiddenLoading()
                WQProgressHUD.showMassage("举报成功！我们会尽快核实并审查该情况")
            }
        }))
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
        }))
        self.present(alertController, animated: true)
    }
    

}

extension WQBSSVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BSSCell_id, for: indexPath) as! WQBSSCell
        cell.likeBtn.addTarget(self, action: #selector(likeBtnClick), for: UIControl.Event.touchUpInside)
        cell.likeBtn.tag = 20 + indexPath.section
        cell.commentBtn.addTarget(self, action: #selector(commentBtnClick), for: UIControl.Event.touchUpInside)
        cell.commentBtn.tag = indexPath.section
        cell.moreBtn.addTarget(self, action: #selector(moreBtnClick), for: UIControl.Event.touchUpInside)
        cell.moreBtn.tag = 60 + indexPath.section
        cell.setData(model: self.datas[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NavigationManager.shared.goToCommentsVC(model: self.datas[indexPath.section], bssVC: self)
    }
}

extension WQBSSVC: CommentsDelegate {
    func updateBSSData(_ model: WQBSSModel) {
        if model.like > 1 {
            UserTool.shared.likes.append(model.id!)
        }else {
            UserTool.shared.likes.removeAll{ $0 == model.id }
        }
        self.datas[model.id!] = model
        self.tableView.reloadData()
    }
}
