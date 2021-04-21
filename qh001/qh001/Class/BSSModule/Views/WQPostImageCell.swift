//
//  WQPostImageCell.swift
//  qh001
//
//  Created by linke50 on 4/18/21.
//

import UIKit

class WQPostImageCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageV.cornerAll(10)
        cancelBtn.cornerAll(10)
    }

}
