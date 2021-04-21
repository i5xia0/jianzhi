//
//  WQVideoVC.swift
//  qh001
//
//  Created by linke50 on 4/14/21.
//

import UIKit
import MJRefresh

private let videoCell_id = "videoCell"

class WQVideoVC: WQBaseVC {

    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQVideoCell", bundle: Bundle.main), forCellReuseIdentifier: videoCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    
    var datas = Array<WQNewsModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "微视频"
        navBarReturn = true
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        tableView.mj_header?.beginRefreshing()
    }
    
    @objc dynamic func headerRefresh(){
        LKNetworkManager.shared.getVideoList { (result) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            let list:Array<Any> = result.data as! Array<Any>
            self.datas = list.map{WQNewsModel.deserialize(from: ($0 as! Dictionary<String,Any>))!}
            self.tableView.reloadData()
        } fail: { (error) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            WQProgressHUD.showMassage(error)
        }
    }


}
extension WQVideoVC: UITableViewDelegate,UITableViewDataSource {
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: videoCell_id, for: indexPath) as! WQVideoCell
        cell.setData(model: self.datas[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NavigationManager.shared.goToVideoPlayVC(video: self.datas[indexPath.section])
    }
}
