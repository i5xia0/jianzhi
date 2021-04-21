//
//  WQNewsVC.swift
//  qh001
//
//  Created by linke50 on 4/15/21.
//

import UIKit
import MJRefresh

private let newsCell_id = "newsCell"

class WQNewsVC: WQBaseVC {

    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQNewsCell", bundle: Bundle.main), forCellReuseIdentifier: newsCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    
    var datas = Array<WQNewsModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "快讯"
        navBarReturn = true
        tableView.snp.makeConstraints { (make) in
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
        LKNetworkManager.shared.getNewsflash { (result) -> (Void) in
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


extension WQNewsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCell_id, for: indexPath) as! WQNewsCell
        cell.setData(model: self.datas[indexPath.row])
        return cell
    }
}
