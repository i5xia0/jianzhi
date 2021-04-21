//
//  WQMyHeaderView.swift
//
//
//  Created by linke50 on 7/18/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import SnapKit

class WQMyHeaderView: UIView {
    var avatarView: UIImageView!
    var nameBtn:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        avatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        avatarView.layer.cornerRadius = 40
        avatarView.clipsToBounds = true
        avatarView.backgroundColor = COLOR_Base.SF5F7FA
        self.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(SafeAreaTopHeight + 30)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        nameBtn = UIButton()
        nameBtn.titleLabel!.font = SFONT.PingFang15
        nameBtn.setTitleColor(COLOR_Base.S303133, for: UIControl.State.normal)
        self.addSubview(nameBtn)
        nameBtn.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
