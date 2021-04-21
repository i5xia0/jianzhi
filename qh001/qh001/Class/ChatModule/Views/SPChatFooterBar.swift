//
//  SPChatFooterBar.swift
//  ShowPay
//
//  Created by linke50 on 7/28/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

protocol FooterBarDelegate {
    func sendMessage(_ message:String)-> Void
    func sendTransfer(_ money: Double)-> Void
}

class SPChatFooterBar: UIView {
    //代理 用于发消息、转账操作
    var footerBarDelegate: FooterBarDelegate!
    // 发送
    lazy var sendBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.addTarget(self, action: #selector(sendAction(_:)), for: .touchUpInside)
        btn.setTitle("发送", for: UIControl.State.normal)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.setTitleColor(COLOR_Base.SBFC2CC, for: UIControl.State.disabled)
        btn.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SEAB300, viewSize: CGSize(width: 36, height: 60)), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SF5F7FA, viewSize: CGSize(width: 36, height: 60)), for: UIControl.State.disabled)
        btn.isEnabled = false
        btn.titleLabel?.font = SFONT.PingFang12
        btn.cornerAll(5)
        addSubview(btn)
        return btn
    }()
    lazy var textViewBG: UIView = {
        let bgview = UIView()
        bgview.cornerAll(5)
        bgview.layer.backgroundColor = COLOR_Base.SF5F7FA.cgColor
        addSubview(bgview)
        return bgview
    }()
    // 消息输入框
    lazy var textView: UITextView = {
        let textField = UITextView.init()
        textField.backgroundColor = .clear
        textField.textContainerInset = UIEdgeInsets(top: 5,left: 0, bottom: 0, right: 0)
        textField.font = SFONT.PingFang12
        textField.delegate = self
        textViewBG.addSubview(textField)
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sendBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(36)
            make.width.equalTo(60)
        }
        textViewBG.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-7)
            make.height.equalTo(36)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(sendBtn.snp.left).offset(-10)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SPChatFooterBar {
    @objc
    func sendAction(_ sender: UIButton) {
        print("发送消息")
        if textView.text != "" {
            self.footerBarDelegate.sendMessage(textView.text)
            textView.text = ""
            sendBtn.isEnabled = false
        }
    }
}

extension SPChatFooterBar: UITextViewDelegate {
    //第一次启动
    func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            sendBtn.isEnabled = false
        }else {
            sendBtn.isEnabled = true
        }
    }
    //文本内容发生变化
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (textView.text == "")  {
            if  1 <= text.count {
            }
        }
        return true
    }
    
}
