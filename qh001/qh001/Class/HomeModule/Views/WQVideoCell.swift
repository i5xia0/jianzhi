//
//  WQVideoCell.swift
//  qh001
//
//  Created by linke50 on 4/14/21.
//

import UIKit

class WQVideoCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setData(model:WQNewsModel){
        timeLabel.text = model.timestamp
        titleLabel.text = model.title
        bgImage.kf.setImage(with: URL(string: model.image!))
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
