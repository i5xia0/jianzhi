//
//  WQNewsCell.swift
//  qh001
//
//  Created by linke50 on 4/15/21.
//

import UIKit

class WQNewsCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    func setData(model:WQNewsModel){
        timeLabel.text = model.timestamp
        contentLabel.text = model.content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.cornerAll(5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
