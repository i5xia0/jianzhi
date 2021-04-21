//
//  WQCustomNavBar.swift
//
//
//  Created by linke50 on 7/18/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class WQCustomNavBar: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var TitleLab: UILabel!
    @IBOutlet weak var rightBtn: UIButton!
    
    var title: String = "" {
        didSet {
            self.TitleLab.text = title
        }
    }
    
    static func customView() -> WQCustomNavBar{
        return  Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! WQCustomNavBar
    }

}
