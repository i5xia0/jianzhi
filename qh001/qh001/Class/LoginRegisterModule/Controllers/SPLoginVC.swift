//
//  SPLoginVC.swift
//  ShowPay
//
//  Created by linke50 on 7/23/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import Toast_Swift
import Starscream

class SPLoginVC: WQBaseVC {
    
    lazy var headerBG: UIImageView = {
        let headerImageV = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ADAPTWIDTH(230)))
        headerImageV.image = #imageLiteral(resourceName: "login_bg")
        self.view.addSubview(headerImageV)
        return headerImageV
    }()
    lazy var welcomeView: UIView = {
        let wView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ADAPTWIDTH(200)))
        view.addSubview(wView)
        let textView = UIView(frame: CGRect.zero)
        wView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(55.0)
        }
        return wView
    }()
    lazy var loginView: UIView = {
        let loginView = UIView(frame: CGRect(x: 0, y: ADAPTWIDTH(200), width: ScreenWidth, height: ScreenHeight - ADAPTWIDTH(200)))
        loginView.cornerAll(20)
        loginView.backgroundColor = .white
        self.view.addSubview(loginView)
        return loginView
    }()
    lazy var titlesView: UIView = {
        let titlesView = UIView(frame: CGRect(x: 0, y: 60, width: ScreenWidth, height: 30))
        let accountLab = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 80, height: 30))
        accountLab.textColor = COLOR_Base.S303133
        accountLab.textAlignment = .center
        accountLab.font = SFONT.System20
        accountLab.text = "账号登录"
        titlesView.addSubview(accountLab)
        self.loginView.addSubview(titlesView)
        return titlesView
    }()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView(frame: CGRect.zero)
        self.loginView.addSubview(bottomView)
//        let  lineView = UIView()
//        lineView.backgroundColor = COLOR_Base.SEDEFF2
//        bottomView.addSubview(lineView)
//        lineView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.width.equalTo(1)
//            make.height.equalTo(12)
//        }
        let registerBtn = CustomButton(type: UIButton.ButtonType.custom)
        bottomView.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(30)
        }
        registerBtn.setTitle("注册账号", for: UIControl.State.normal)
        registerBtn.setTitleColor(COLOR_Base.S909399, for: UIControl.State.normal)
        registerBtn.titleLabel?.font = SFONT.System15
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: UIControl.Event.touchUpInside)
        let agreementBtn = CustomButton(type: UIButton.ButtonType.custom)
        bottomView.addSubview(agreementBtn)
        agreementBtn.snp.makeConstraints { (make) in
            make.top.equalTo(registerBtn.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(30)
        }
        let attrString = NSMutableAttributedString(string: "*登录/注册即代表您同意《App隐私协议》")
        let attr: [NSAttributedString.Key : Any] = [.font: SFONT.PingFang10 as Any,.foregroundColor: UIColor(red: 0.38, green: 0.5, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        let strSubAttr1: [NSMutableAttributedString.Key: Any] = [.font: SFONT.PingFang12 as Any,.foregroundColor: COLOR_Base.S909399]
        attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: 12))
        let strSubAttr2: [NSMutableAttributedString.Key: Any] = [.font: SFONT.PingFang12 as Any,.foregroundColor: UIColor.red]
        attrString.addAttributes(strSubAttr2, range: NSRange(location: 12, length: 9))
        agreementBtn.setAttributedTitle(attrString, for: .normal)
//        setTitle("已阅读并同意用户注册及使用《App隐私协议》", for: UIControl.State.normal)
        agreementBtn.addTarget(self, action: #selector(agreementBtnClick), for: UIControl.Event.touchUpInside)
        agreementBtn.setTitleColor(UIColor.red, for: UIControl.State.normal)
        agreementBtn.titleLabel?.font = SFONT.System12
        return bottomView
    }()
    lazy var accountLoginView: UIView = {
        let childVC = SPLoginSubVC.init()
        addChild(childVC)
        let view = childVC.view
        view!.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 80, height: 300)
        self.loginView.addSubview(view!)
        return view!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        navBarReturn = true
        navBar.backgroundColor = UIColor.clear
    }
    
}

//点击事件方法
extension SPLoginVC {
    
    @objc  dynamic func registerBtnClick() {
        let registerVC = SPRegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc  dynamic func agreementBtnClick() {
        let webVC = SPAppWebVC()
        webVC.urlString = "https://www.baidu.com"
        webVC.title = "App隐私协议"
        self.navigationController?.present(webVC, animated: true, completion: nil)
    }
}


extension SPLoginVC {
    //MARK: 布局视图
    func setupView() {
        headerBG.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(ADAPTWIDTH(230))
        }
        welcomeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(ADAPTWIDTH(200))
        }
        loginView.snp.makeConstraints { (make) in
            make.top.equalTo(ADAPTWIDTH(200))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        titlesView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        }
        accountLoginView.snp.makeConstraints { (make) in
            make.top.equalTo(titlesView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(150)
        }
        bottomView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().offset( -(30 + SafeAreaBottomHeight))
        }
    }
    
    
}
