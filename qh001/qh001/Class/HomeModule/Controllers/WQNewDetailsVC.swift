//
//  WQNewDetailsVC.swift
//  qh001
//
//  Created by linke50 on 4/15/21.
//

import UIKit

private let newDetailsCell_id = "newDetailsCell"

class WQNewDetailsVC: WQBaseVC {
    
    lazy var tableView:WQBaseTableView = {
        let tableView = WQBaseTableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = COLOR_Base.SF5F7FA
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WQNewDetailsCell", bundle: Bundle.main), forCellReuseIdentifier: newDetailsCell_id)
        view.addSubview(tableView)
        return tableView
    }()
    var news: WQNewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "资讯"
        navBarReturn = true
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WQNewDetailsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newDetailsCell_id, for: indexPath) as! WQNewDetailsCell
        cell.setModel(model: news)
        return cell
    }
}
