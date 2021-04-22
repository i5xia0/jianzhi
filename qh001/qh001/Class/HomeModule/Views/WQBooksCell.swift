//
//  WQBooksCell.swift
//  qh001
//
//  Created by linke50 on 4/22/21.
//

import UIKit

class WQBooksCell: UICollectionViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    func setData(model:WQBookModel){
        imageV.kf.setImage(with: URL(string: model.image!))
        titleLab.text = model.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cornerAll(10)
    }

}
