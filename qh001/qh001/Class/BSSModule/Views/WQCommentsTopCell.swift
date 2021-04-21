//
//  WQCommentsTopCell.swift
//  qh001
//
//  Created by linke50 on 4/16/21.
//

import UIKit

class WQCommentsTopCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    func setData(model:WQBSSModel){
        nameLab.text = model.name
        avatarImage.kf.setImage(with: URL(string: model.avatars!))
        timeLab.text = model.timestamp
        textLab.text = model.content
        contentImage.kf.setImage(with: URL(string: model.image ?? ""), placeholder: UIImage(named: "login_bg"))
        if model.like > 0 {
            likeBtn.isSelected = true
            likeBtn.setTitle(" \(model.like)", for: UIControl.State.normal)
            likeBtn.setTitleColor(COLOR_Base.SEAB300, for: UIControl.State.normal)
        }else {
            likeBtn.setTitle("", for: UIControl.State.normal)
            likeBtn.setTitleColor(COLOR_Base.SEAB300, for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        avatarImage.cornerAll(20)
        likeBtn.setImage(UIImage.iconfont(text: "\u{e60c}", size: 18), for: UIControl.State.normal)
        likeBtn.setImage(UIImage.iconfont(text: "\u{e60c}", size: 18,color: COLOR_Base.SEAB300), for: UIControl.State.selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
