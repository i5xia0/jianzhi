//
//  SPLoginSubVC.swift
//  ShowPay
//
//  Created by linke50 on 8/21/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPLoginSubVC: WQBaseVC {
    
    var userType: String!
    
    lazy var accountTextField: UITextField = {
        let accountField = RadiusTextField(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 80, height: 40))
        view.addSubview(accountField)
        accountField.placeholder = "用户名"
        accountField.delegate = self
        return accountField
    }()
    lazy var passwordTextField: PasswordTextField = {
        let passwordField = PasswordTextField()
        passwordField.placeholder = "密码"
        view.addSubview(passwordField)
        passwordField.delegate = self
        return passwordField
    }()
    private var remember = UILabel()
    var isRemember = false {
        didSet {
            if isRemember  {
                remember.text = "\u{eaef}"
            }else {
                remember.text = "\u{e64c}"
            }
        }
    }
//    lazy var rememberCodeView: UIView = {
//        let rView = UIView()
//        let btn = UIButton(type: .custom)
//        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btn.isSelected = true
//        let label = UILabel(frame: CGRect(x:0, y: 0, width: 30, height: 30))
//        label.font =  UIFont.wqicon(size: 18)
//        label.text = "\u{eaef}"
//        label.textColor = COLOR_Base.SEAB300
//        btn.addSubview(label)
//        remember = label
//        btn.addTarget(self, action: #selector(changeStatesClick(sender:)), for: UIControl.Event.touchUpInside)
//        rView.addSubview(btn)
//        let codelab = UILabel(frame: CGRect(x:30, y: 0, width: 60, height: 30))
//        codelab.font = SFONT.System12
//        codelab.text = "记住密码"
//        codelab.textColor = COLOR_Base.SBFC2CC
//        rView.addSubview(codelab)
//        view.addSubview(rView)
//        return rView
//    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: UIButton.ButtonType.custom)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderColor = COLOR_Base.SEDEFF2.cgColor
        loginButton.layer.borderWidth = 1
        view.addSubview(loginButton)
        loginButton.setTitle("登录", for: UIControl.State.normal)
        loginButton.setTitleColor(.white, for: UIControl.State.normal)
        loginButton.setTitleColor(COLOR_Base.SBFC2CC, for: UIControl.State.disabled)
        loginButton.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SEAB300, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.normal)
        loginButton.setBackgroundImage(UIImage.imageFromColor(color: .white, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.disabled)
        loginButton.isEnabled = false
        loginButton.titleLabel?.font = SFONT.System16
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: UIControl.Event.touchUpInside)
        return loginButton
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //MARK: 布局视图
        accountTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(accountTextField.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
//        rememberCodeView.snp.makeConstraints { (make) in
//            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(30)
//        }
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private var startCount = 60
    private var timer: Timer!
    
    @objc
    dynamic func changeStatesClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        self.isRemember = sender.isSelected
    }
    @objc dynamic func loginButtonClick() {
        WQProgressHUD.showLoading()
        LKNetworkManager.shared.login(username: self.accountTextField.text!, password: self.passwordTextField.text!) { (result) -> (Void) in
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage("登录成功")
            UserTool.shared.login(userData: result.data as Any)
            NotificationCenter.default.post(name: NSNotification.Name.login, object: nil, userInfo: nil)
            self.leftBtnClick()
        } fail: { (error) -> (Void) in
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage(error)
        }
    }
}


extension SPLoginSubVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.passwordTextField {
            if self.passwordTextField.eyeHidden == true {
                self.passwordTextField.eyeOpen = false
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let changeStr = NSMutableString(string: textField.text ?? "")
        changeStr.replaceCharacters(in: range, with: string)
        if changeStr.length == 0 {
            self.loginButton.isEnabled = false
        }else {
            switch textField {
            case self.accountTextField:
                if self.passwordTextField.text != "" {
                    self.loginButton.isEnabled = true
                }else {
                    self.loginButton.isEnabled = false
                }
                break
            case self.passwordTextField:
                if self.accountTextField.text != ""{
                    self.loginButton.isEnabled = true
                }else {
                    self.loginButton.isEnabled = false
                }
                break
            default:
                break
            }
            
        }
        if textField == self.passwordTextField {
            let changeStr = NSMutableString(string: textField.text ?? "")
            changeStr.replaceCharacters(in: range, with: string)
            if changeStr.length == 0 {
                self.passwordTextField.eyeHidden = true
            }else {
                self.passwordTextField.eyeHidden = false
            }
            //处理明文密文切换时输入不被清空（关键代码）
            if self.passwordTextField.isSecureTextEntry {
                self.passwordTextField.text = changeStr as String
                return false
            }
        }
        return true
    }
}


