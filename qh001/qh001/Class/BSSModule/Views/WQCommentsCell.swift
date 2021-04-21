//
//  WQCommentsCell.swift
//  qh001
//
//  Created by linke50 on 4/16/21.
//

import UIKit

class WQCommentsCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    func setData(model:WQCommentModel){
        nameLab.text = model.name
        avatarImage.image = UIImage(named: model.avatars!)
        timeLab.text = model.timestamp
        contentLab.text = model.content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        avatarImage.cornerAll(20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
