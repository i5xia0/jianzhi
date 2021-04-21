//
//  WQHomeItemCell.swift
//  qh001
//
//  Created by linke50 on 4/14/21.
//

import UIKit

class WQHomeItemCell: UICollectionViewCell {

    @IBOutlet weak var itemLogo: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    var item:Dictionary<String,String>!{
        didSet{
            itemLogo.image = UIImage.iconfont(text: item["logo"]!, size: 30, color: COLOR_Base.S303133)
            itemName.text = item["name"]!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cornerAll(15)
    }

}
