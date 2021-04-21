//
//  CountryCodeTextField.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class PhoneTextField:  RadiusTextField {
    
    var countryCode: String = "86"{
        didSet {
            countryCodeLabel.text = "+" + countryCode
        }
    }
    
    private let countryCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        placeholder = "手机号"
        countryCode = "86"
        rightViewWithCountryCode(countryCode)
        keyboardType = UIKeyboardType.phonePad
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func  rightViewWithCountryCode(_ code:String) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
        countryCodeLabel.text = "+" + code
        countryCodeLabel.font = SFONT.System12
        countryCodeLabel.textColor = COLOR_Base.S303133
       countryCodeLabel.textAlignment = .right
        btn.addSubview(countryCodeLabel)
        let label = UILabel(frame: CGRect(x:45, y: 0, width: 10, height: 40))
        label.font =  UIFont.showicon(ofSize: 7)
        label.text = "\u{e627}"
        label.textColor = COLOR_Base.S303133
        btn.addSubview(label)
        btn.addTarget(self, action: #selector(getCountryCodeClick(sender:)), for: UIControl.Event.touchUpInside)
        rightView.addSubview(btn)
        self.rightViewMode = .always
        self.rightView = rightView
    }
    @objc
    dynamic func getCountryCodeClick(sender:UIButton) {
       
    }
}
