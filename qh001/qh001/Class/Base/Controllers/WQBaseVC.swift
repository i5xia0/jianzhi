//
//  WQBaseVC.swift
//  qh001
//
//  Created by linke50 on 4/6/21.
//

import UIKit

class WQBaseVC: UIViewController {

    lazy var navBar: WQCustomNavBar = {
        let navBar = WQCustomNavBar.customView()
        navBar.frame =   CGRect(x: 0, y: 0, width: ScreenWidth, height: NavgationHeight)
        navBar.backgroundColor = .white
        navBar.title = self.title ?? ""
        navBar.leftBtn.addTarget(self, action: #selector(leftBtnClick), for: UIControl.Event.touchUpInside)
        navBar.border([.bottom], COLOR_Base.SF5F7FA, 1)
        view.addSubview(navBar)
        return navBar
    }()
    var navBarReturn: Bool? {
        didSet {
            if navBarReturn == true {
                navBar.leftBtn.isHidden = false
            }else {
                navBar.leftBtn.isHidden = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = COLOR_Base.SF5F7FA
       
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
extension WQBaseVC {
    //MARK: 点击事件方法
    @objc
    dynamic func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
