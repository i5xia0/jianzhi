//
//  WQMainTabBarVC.swift
//   
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class WQMainTabBarVC: UITabBarController {
    
    private let SHOWVCs : Array = [WQHomeVC.self,
                                   WQMarketVC.self,
                                   WQBSSVC.self,
                                   WQMyVC.self]
    private let titles : Array! = ["首页",
                                   "行情",
                                   "论坛",
                                   "我的"]
    private let images : Array! = [IconFont.HOME,
                                   IconFont.Market,
                                   IconFont.BBS,
                                   IconFont.My]
    private let selectedImages : Array! = [IconFont.HOME,
                                           IconFont.Market,
                                           IconFont.BBS,
                                           IconFont.My]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去掉黑线
        if #available(iOS 13, *) {
            let appearance = tabBar.standardAppearance.copy()
            appearance.backgroundImage = UIImage.init()
            appearance.shadowImage = UIImage.init()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
        } else {
            tabBar.backgroundImage = UIImage.init()
            tabBar.shadowImage = UIImage.init()
        }
        self.tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
        self.tabBar.tintColor = SRGBHEXCOLOR(rgbValue: 0xff303133) //设置选中颜色
        self.tabBar.barTintColor = .white //背景色
        //添加阴影
        self.tabBar.layer.shadowColor = UIColor.black.cgColor;
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2);
        self.tabBar.layer.shadowOpacity = 0.03;
        //添加子控制器
        for i in 0...(SHOWVCs.count - 1) {
            addChildViewController(ShowVC: SHOWVCs[i], title: titles[i], image: images[i].rawValue, selectedImage: selectedImages[i].rawValue)
        }
        self.selectedIndex = 0
    }
    // 封装方法
    func addChildViewController(ShowVC:WQBaseVC.Type!,title:String!,image:String!,selectedImage:String!) {
        let SPVC = ShowVC.init()
        let baseNav = UINavigationController(rootViewController: SPVC)
        baseNav.navigationBar.isHidden = true
        let barItem = UITabBarItem(title: title,
                                   image: UIImage.iconfont(text: image, size: 25, color: UIColor.gray),
                                   selectedImage: UIImage.iconfont(text: selectedImage, size: 25, color: COLOR_Base.S303133))
//        barItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        baseNav.tabBarItem = barItem
        self.addChild(baseNav)
//        SPVC.tabBarItem = barItem
//        self.addChild(SPVC)
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
