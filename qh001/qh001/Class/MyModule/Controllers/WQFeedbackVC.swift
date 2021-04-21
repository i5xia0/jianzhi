//
//  WQFeedbackVC.swift
//  qh001
//
//  Created by linke50 on 4/12/21.
//

import UIKit

class WQFeedbackVC: WQBaseVC {

    lazy var titleLab: UILabel = {
        let tLabel = UILabel()
        tLabel.text = "您有什么问题或建议想对我们说？"
        tLabel.font = SFONT.PingFang12
        view.addSubview(tLabel)
        return tLabel
    }()
    lazy var contentText: UITextView = {
        let contentText = UITextView()
        contentText.backgroundColor = .white
        contentText.layer.masksToBounds = true
        contentText.layer.cornerRadius = 5
        contentText.delegate = self
        view.addSubview(contentText)
        return contentText
    }()
    lazy var submitButton: UIButton = {
        let submitButton = UIButton(type: UIButton.ButtonType.custom)
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderColor = COLOR_Base.SEDEFF2.cgColor
        submitButton.layer.borderWidth = 1
        view.addSubview(submitButton)
        submitButton.setTitle("问题提交", for: UIControl.State.normal)
        submitButton.setTitleColor(COLOR_Base.SBFC2CC, for: UIControl.State.disabled)
        submitButton.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SEAB300, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.normal)
        submitButton.setBackgroundImage(UIImage.imageFromColor(color: .white, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.disabled)
        submitButton.isEnabled = false
        submitButton.titleLabel?.font = SFONT.System16
        submitButton.addTarget(self, action: #selector(submitButtonClick), for: UIControl.Event.touchUpInside)
        return submitButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "意见反馈"
        navBarReturn = true
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
        }
        
        contentText.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(150)
        }
        contentText.becomeFirstResponder()
        
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentText.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
    }
    

    @objc dynamic func submitButtonClick() {
        self.view.endEditing(true)
        WQProgressHUD.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            WQProgressHUD.hiddenLoading()
            WQProgressHUD.showMassage("意见反馈已提交！")
            self.leftBtnClick()
        }
    }

}

extension WQFeedbackVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let changeStr = NSMutableString(string: textView.text ?? "")
        changeStr.replaceCharacters(in: range, with: text)
        if changeStr.length == 0 {
            self.submitButton.isEnabled = false
        }else {
            self.submitButton.isEnabled = true
        }
        return true
    }
}
