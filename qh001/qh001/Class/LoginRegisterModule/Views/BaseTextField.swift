//
//  BaseTextField.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftViewSpacing()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
