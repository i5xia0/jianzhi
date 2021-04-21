//
//  BaseTextField.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class RadiusTextField: BaseTextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = COLOR_Base.SF5F7FA
        self.font = SFONT.PingFang12
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
