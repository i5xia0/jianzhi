//
//  UITextField+Common.swift
//  ShowPay
//
//  Created by linke50 on 8/7/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func  leftViewSpacing() {
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
    }
}
