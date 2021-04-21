//
//  WQSlipMenuCell.swift
//  qh001
//
//  Created by linke50 on 4/19/21.
//

import UIKit

class WQSlipMenuCell: UICollectionViewCell {
    var titleLab: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLab = UILabel()
        titleLab.font = SFONT.PingFang10
        titleLab.textAlignment = .center
        addSubview(titleLab)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.frame = self.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
