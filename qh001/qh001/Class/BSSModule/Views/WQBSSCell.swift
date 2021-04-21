//
//  WQBSSCell.swift
//  qh001
//
//  Created by linke50 on 4/13/21.
//

import UIKit

class WQBSSCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var imagebg: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var timeLab: UILabel!
    
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
            likeBtn.isSelected = false
            likeBtn.setTitle("", for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.cornerAll(20)
        likeBtn.setImage(UIImage.iconfont(text: "\u{e60c}", size: 18), for: UIControl.State.normal)
        likeBtn.setImage(UIImage.iconfont(text: "\u{e60c}", size: 18,color: COLOR_Base.SEAB300), for: UIControl.State.selected)
        likeBtn.setTitleColor(COLOR_Base.SEAB300, for: UIControl.State.selected)
//        commentBtn.setImage(UIImage.iconfont(text: "\u{e61e}", size: 20), for: UIControl.State.normal)
//        moreBtn.setImage(UIImage.iconfont(text: "\u{e689}", size: 18), for: UIControl.State.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
