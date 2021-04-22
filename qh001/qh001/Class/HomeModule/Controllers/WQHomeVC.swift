//
//  WQHomeVC.swift
//  qh001
//
//  Created by linke50 on 4/7/21.
//

import UIKit
import LLCycleScrollView
import MJRefresh

private let homeCell_id = "homeCell"

class WQHomeVC: WQBaseVC {
    
    let banner = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, width: ScreenWidth, height: ADAPTWIDTH(180)))
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ADAPTWIDTH(180) + 80))
        headerView.backgroundColor = COLOR_Base.SF5F7FA
        
        banner.delegate = self
        // 是否自动滚动
        banner.autoScroll = true

        // 是否无限循环，此属性修改了就不存在轮播的意义了 😄
        banner.infiniteLoop = true

        // 滚动间隔时间(默认为2秒)
        banner.autoScrollTimeInterval = 3.0

        // 设置图片显示方式=UIImageView的ContentMode
        banner.imageViewContentMode = .scaleToFill

        // 设置滚动方向（ vertical || horizontal ）
        banner.scrollDirection = .horizontal

        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        banner.customPageControlStyle = .snake

        // 非.system的状态下，设置PageControl的tintColor
        banner.customPageControlInActiveTintColor = UIColor.gray

        // 设置.system系统的UIPageControl当前显示的颜色
        banner.pageControlCurrentPageColor = UIColor.white

        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        banner.customPageControlIndicatorPadding = 8.0

        // 设置PageControl的位置 (.left, .right 默认为.center)
        banner.pageControlPosition = .center
        headerView.addSubview(banner)
        let homeItemView = WQHomeItemView(frame: CGRect(x: 0, y: ADAPTWIDTH(180), width: ScreenWidth, height: 80))
        headerView.addSubview(homeItemView)
        view.addSubview(headerView)
        return headerView
    }()
    
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQHomeCell", bundle: Bundle.main), forCellReuseIdentifier: homeCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    
    
    var datas = Array<WQNewsModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        navBarReturn = false
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.tableHeaderView = headerView
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        tableView.mj_header?.beginRefreshing()
    }
    

    @objc dynamic func headerRefresh(){
        LKNetworkManager.shared.getNews { (result) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            let list:Array<Any> = result.data as! Array<Any>
            self.datas = list.map{WQNewsModel.deserialize(from: ($0 as! Dictionary<String,Any>))!}
            var imagePaths = Array<String>()
            for i in 0...2 {
                imagePaths.append(self.datas[i].image!)
            }
            self.banner.imagePaths = imagePaths
            self.tableView.reloadData()
        } fail: { (error) -> (Void) in
            self.tableView.mj_header?.endRefreshing()
            WQProgressHUD.showMassage(error)
        }
    }

}

extension WQHomeVC: UITableViewDelegate,UITableViewDataSource {
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
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell_id, for: indexPath) as! WQHomeCell
        cell.setData(model: self.datas[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NavigationManager.shared.goToNewDetailsVC(news: self.datas[indexPath.section])
    }
}

extension WQHomeVC: LLCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        NavigationManager.shared.goToNewDetailsVC(news: self.datas[index])
    }
    
}
