//
//  SPRegisterSubVC.swift
//  ShowPay
//
//  Created by linke50 on 8/21/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPRegisterSubVC: WQBaseVC {
    
    var userType: String!
    
    lazy var userNameTextField: UITextField = {
        let textField = RadiusTextField()
        textField.placeholder = "请输入您的用户名"
        textField.delegate = self
        view.addSubview(textField)
        return textField
    }()
    lazy var passwordTextField: PasswordTextField = {
        let passwordField = PasswordTextField()
        view.addSubview(passwordField)
        passwordField.placeholder = "密码"
        passwordField.delegate = self
        return passwordField
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderColor = COLOR_Base.SEDEFF2.cgColor
        button.layer.borderWidth = 1
        view.addSubview(button)
        button.setTitle("注册", for: UIControl.State.normal)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.setTitleColor(COLOR_Base.SBFC2CC, for: UIControl.State.disabled)
        button.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SEAB300, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage.imageFromColor(color: .white, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.disabled)
        button.isEnabled = false
        button.titleLabel?.font = SFONT.System16
        button.addTarget(self, action: #selector(nextButtonClick), for: UIControl.Event.touchUpInside)
        return button
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
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        nextButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
    }
    
    private var startCount = 60
    private var timer: Timer!
    @objc
    dynamic func nextButtonClick() {
        WQProgressHUD.showLoading()
        LKNetworkManager.shared.register(username: self.userNameTextField.text!, password: self.passwordTextField.text!) { (result) -> (Void) in
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage("注册成功,请登录")
            self.leftBtnClick()
        } fail: { (error) -> (Void) in
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage(error)
        }
    }
}
extension SPRegisterSubVC: UITextFieldDelegate {
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
        let changeStr = NSMutableString(string: textField.text ?? "")
        changeStr.replaceCharacters(in: range, with: string)
        if changeStr.length == 0 {
            self.nextButton.isEnabled = false
        }else {
            switch textField {
            case self.passwordTextField:
                if self.userNameTextField.text != "" {
                    self.nextButton.isEnabled = true
                }else {
                    self.nextButton.isEnabled = false
                }
                break
            case self.userNameTextField:
                if self.passwordTextField.text != "" {
                    self.nextButton.isEnabled = true
                }else {
                    self.nextButton.isEnabled = false
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
