//
//  SPSwitchCell.swift
//  ShowPay
//
//  Created by linke50 on 7/17/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPSwitchCell: UITableViewCell {

    
    lazy var rSwitch:UISwitch = {
        let sSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        sSwitch.thumbTintColor = UIColor.white
        sSwitch.onTintColor = COLOR_Base.SEAB300
        sSwitch.isOn = true
        return sSwitch
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setupSubView()
    }
    func setupSubView()  {
        self.accessoryView = rSwitch
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
