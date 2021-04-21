//
//  SPRegisterVC.swift
//  ShowPay
//
//  Created by linke50 on 7/23/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit


class SPRegisterVC: WQBaseVC {
    
    lazy var registerNavBar: WQCustomNavBar = {
        let navBar = WQCustomNavBar.customView()
        navBar.frame =   CGRect(x: 0, y: 0, width: ScreenWidth, height: NavgationHeight)
        navBar.backgroundColor = .white
        navBar.leftBtn.addTarget(self, action: #selector(leftBtnClick), for: UIControl.Event.touchUpInside)
        self.view.addSubview(navBar)
        return navBar
    }()
    
    lazy var titlesView: UIView = {
        let titlesView = UIView(frame: CGRect(x: 40, y: 0, width: ScreenWidth - 80, height: 30))
        registerNavBar.contentView.addSubview(titlesView)
        let accountLab = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 80, height: 30))
        accountLab.textColor = COLOR_Base.S303133
        accountLab.textAlignment = .center
        accountLab.font = SFONT.System20
        accountLab.text = "注册"
        titlesView.addSubview(accountLab)
        return titlesView
    }()
    lazy var phoneRegisterView: UIView = {
        let childVC = SPRegisterSubVC.init()
        addChild(childVC)
        let view = childVC.view!
        view.frame = CGRect(x: 0, y: NavgationHeight, width: ScreenWidth, height: ScreenHeight - NavgationHeight)
        self.view.addSubview(view)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
    }
    
    
}

extension SPRegisterVC {
    //MARK: 点击事件方法
    @objc
    dynamic override func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SPRegisterVC {
    //MARK: 布局视图
    func setupView() {
        registerNavBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(NavgationHeight)
        }
        titlesView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        }
        phoneRegisterView.snp.makeConstraints { (make) in
            make.top.equalTo(registerNavBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
