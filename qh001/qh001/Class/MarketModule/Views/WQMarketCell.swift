//
//  WQMarketCell.swift
//  qh001
//
//  Created by linke50 on 4/8/21.
//

import UIKit

class WQMarketCell: UITableViewCell {
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var codeLab: UILabel!
    @IBOutlet weak var nowVLab: UILabel!
    @IBOutlet weak var upDownRateLab: UILabel!
    @IBOutlet weak var openInterestLab: UILabel!
    
    func setData(model:WQMarketModel){
        self.nameLab.text = model.contractName
        self.codeLab.text = model.symbol
        self.nowVLab.text = model.nowV!.contains("+") ? model.nowV!.replacingOccurrences(of: "+", with: "") : model.nowV!.replacingOccurrences(of: "-", with: "")
        self.upDownRateLab.text = model.upDownRate
        self.openInterestLab.text = model.openInterest
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
