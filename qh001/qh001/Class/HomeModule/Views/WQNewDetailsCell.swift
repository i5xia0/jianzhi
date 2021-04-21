//
//  WQNewDetailsCell.swift
//  qh001
//
//  Created by linke50 on 4/16/21.
//

import UIKit

class WQNewDetailsCell: UITableViewCell {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var contentLab: UILabel!
    func setModel(model:WQNewsModel) {
        titleLab.sizeToFit()
        titleHeight.constant = titleLab.height
        titleLab.text = model.title
        timeLab.text = model.timestamp
        newImage.kf.setImage(with: URL(string: model.image!))
        contentLab.text = model.content
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
