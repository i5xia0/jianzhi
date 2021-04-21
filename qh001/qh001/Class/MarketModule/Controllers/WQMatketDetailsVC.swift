//
//  WQMatketDetailsVC.swift
//  qh001
//
//  Created by linke50 on 4/18/21.
//

import UIKit

class WQMatketDetailsVC: WQBaseVC {

    var stockChartView: HSStockChartView!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var nowVLab: UILabel!
    @IBOutlet weak var upDownRateLab: UILabel!
    @IBOutlet weak var upDownLab: UILabel!
    @IBOutlet weak var openPLab: UILabel!
    @IBOutlet weak var highPLab: UILabel!
    @IBOutlet weak var lowPLab: UILabel!
    @IBOutlet weak var curVolumeLab: UILabel!
    @IBOutlet weak var openInterestLab: UILabel!
    @IBOutlet weak var masukuraLab: UILabel!
    
    lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        let title = UILabel()
        title.font = SFONT.PingFang16
        title.text = market.contractName
        title.textColor = COLOR_Base.S303133
        view.addSubview(title)
        title.sizeToFit()
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        let code = UILabel()
        code.font = SFONT.PingFang12
        code.text = market.symbol
        code.textColor = COLOR_Base.S303133
        view.addSubview(code)
        code.sizeToFit()
        code.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom)
            make.centerX.equalToSuperview()
        }
        return view
    }()
    lazy var menuView: UIView = {
        let menuView = WQSlipMenuView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20),titles: ["1m","5m","15m","30m","1h","日K","周K","月K"])
        menuView.delegate = self
        detailsView.addSubview(menuView)
        return menuView
    }()
    var market: WQMarketModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        navBarReturn = true
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }
        menuView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        self.nowVLab.text = self.market.nowV
        self.upDownLab.text = self.market.upDown
        self.upDownRateLab.text = self.market.upDownRate
        self.selectedMenu("1")
    }
    

    func removeTheSymbol(num:String) -> Float {
        var str = num
        str = str.contains("+") ? str.replacingOccurrences(of: "+", with: "") : str.replacingOccurrences(of: "-", with: "")
        return Float(str)!
    }

}
extension WQMatketDetailsVC: SlipMenuDelegate{
    func selectedMenu(_ number: String) {
        stockChartView = HSStockChartView()
        view.addSubview(stockChartView)
        stockChartView.snp.makeConstraints { make in
                make.top.equalTo(detailsView.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
        }
        WQProgressHUD.showLoading()
        LKNetworkManager.shared.getContract(contractid: market.contractID!, type: number) { [weak self] (result) -> (Void) in
            WQProgressHUD.hiddenLoading()
            self!.market = WQMarketModel.deserialize(from: (result.data as! Dictionary<String,Any>))
            self!.nowVLab.text = String(self!.removeTheSymbol(num: self!.market.nowV!))
            self!.upDownLab.text = self!.market.upDown
            self!.upDownRateLab.text = self!.market.upDownRate
            self!.openPLab.text = "开 " + String(self!.removeTheSymbol(num: self!.market.openP!))
            self!.highPLab.text = "高 " + String(self!.removeTheSymbol(num: self!.market.highP!))
            self!.lowPLab.text = "低 " + String(self!.removeTheSymbol(num: self!.market.lowP!))
            self!.curVolumeLab.text = "总手 " + self!.market.curVolume!
            self!.openInterestLab.text = "持仓 " + self!.market.openInterest!
            self!.masukuraLab.text = "日增 " + String(self!.market.masukura ?? 0)
            let group = HSStockChartModelGroup()
            for timedata in self!.market.timeData! {
                let model = HSStockChartModel()
                model.date = timedata.timeStamp!
                model.open = CGFloat(self!.removeTheSymbol(num: timedata.openP!))
                model.close = CGFloat(self!.removeTheSymbol(num: timedata.preCloseP!))
                model.high = CGFloat(self!.removeTheSymbol(num: timedata.highP!))
                model.low = CGFloat(self!.removeTheSymbol(num: timedata.lowP!) )
                model.vol = CGFloat(timedata.curValue!)
                group.chartModelArray.append(model)
            }
            self?.stockChartView.modelGroup = group
            self?.stockChartView.reloadData()
        } fail: { (error) -> (Void) in
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage(error)
        }
    }
}

