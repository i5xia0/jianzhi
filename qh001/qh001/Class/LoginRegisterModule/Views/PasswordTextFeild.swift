//
//  PasswordTextField.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class PasswordTextField: RadiusTextField {
    
    var eyeHidden = true {
        didSet {
            self.rightView?.isHidden = eyeHidden
        }
    }
    private var eye = UILabel()
    var eyeOpen = false {
        didSet {
            if eyeOpen {
                eye.text = "\u{e641}"
                let text = self.text
                self.text = ""
                self.isSecureTextEntry = false
                self.text = text
                
            }else {
                eye.text = "\u{e901}"
                let text = self.text
                self.text = ""
                self.isSecureTextEntry = true
                self.text = text
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSecureTextEntry = true
        rightViewWithEyeButton()
        self.rightView?.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  rightViewWithEyeButton() {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        let label = UILabel(frame: CGRect(x:15, y: 0, width: 20, height: 40))
        label.font =  UIFont.iconfont(ofSize: 15)
        label.text = "\u{e901}"
        label.textColor = COLOR_Base.S303133
        btn.addSubview(label)
        eye = label
        btn.addTarget(self, action: #selector(changeEyeStatesClick(sender:)), for: UIControl.Event.touchUpInside)
        rightView.addSubview(btn)
        self.rightViewMode = .always
        self.rightView = rightView
    }
    @objc
    dynamic func changeEyeStatesClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        self.eyeOpen = sender.isSelected
    }
}

//extension PasswordTextField: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if self.eyeHidden == true {
//            self.eyeOpen = false
//        }
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let changeStr = NSMutableString(string: textField.text ?? "")
//        changeStr.replaceCharacters(in: range, with: string)
//        if changeStr.length == 0 {
//            self.eyeHidden = true
//        }else {
//            self.eyeHidden = false
//        }
//        //处理明文密文切换时输入不被清空（关键代码）
//        if textField==self&&self.isSecureTextEntry{
//            self.text = changeStr as String
//            return false
//        }
//        return true
//    }
//}
