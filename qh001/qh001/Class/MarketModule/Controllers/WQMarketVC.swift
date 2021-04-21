//
//  WQMarketVC.swift
//  qh001
//
//  Created by linke50 on 4/7/21.
//

import UIKit
import MJRefresh
//marketCell
private let marketCell_id = "marketCell"

class WQMarketVC: WQBaseVC {
    
    lazy var titlesView: UIView = {
        let titlesView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        titlesView.backgroundColor = .white
        titlesView.border([.top,.bottom], COLOR_Base.SF5F7FA, 1.0)
        let nameCodeLab = UILabel()
        nameCodeLab.font = SFONT.PingFang12
        nameCodeLab.textAlignment = .center
        nameCodeLab.text = "名称代码"
        titlesView.addSubview(nameCodeLab)
        nameCodeLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/4)
        }
        let nowVLab = UILabel()
        nowVLab.font = SFONT.PingFang12
        nowVLab.textAlignment = .center
        nowVLab.text = "最新价"
        titlesView.addSubview(nowVLab)
        nowVLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(nameCodeLab.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/4)
        }
        let upDownRateLab = UILabel()
        upDownRateLab.font = SFONT.PingFang12
        upDownRateLab.textAlignment = .center
        upDownRateLab.text = "涨跌"
        titlesView.addSubview(upDownRateLab)
        upDownRateLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(nowVLab.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/4)
        }
        let openInterestLab = UILabel()
        openInterestLab.font = SFONT.PingFang12
        openInterestLab.textAlignment = .center
        openInterestLab.text = "持仓量"
        titlesView.addSubview(openInterestLab)
        openInterestLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(upDownRateLab.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/4)
        }
        view.addSubview(titlesView)
        return titlesView
    }()
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQMarketCell", bundle: Bundle.main), forCellReuseIdentifier: marketCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    var datas = Array<WQMarketModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "行情"
        navBarReturn = false
        titlesView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titlesView.snp.bottom)
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
        LKNetworkManager.shared.mainContract { (result) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            let list:Array<Any> = result.data as! Array<Any>
            self.datas = list.map{WQMarketModel.deserialize(from: ($0 as! Dictionary<String,Any>))!}
            self.tableView.reloadData()
        } fail: { (error) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            WQProgressHUD.showMassage(error)
        }

     }

}
extension WQMarketVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: marketCell_id, for: indexPath) as! WQMarketCell
        cell.setData(model: self.datas[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NavigationManager.shared.gotoMarketDetailsVC(model: self.datas[indexPath.section])
    }
}
