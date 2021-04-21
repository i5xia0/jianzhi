//
//  WQHomeCell.swift
//  qh001
//
//  Created by linke50 on 4/14/21.
//

import UIKit
import Kingfisher
class WQHomeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    func setData(model:WQNewsModel){
        titleLabel.text = model.title
        timeLabel.text = model.timestamp
        imageV.kf.setImage(with: URL(string: model.image!))
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
