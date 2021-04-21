//
//  WQNewsModel.swift
//  qh001
//
//  Created by linke50 on 4/20/21.
//

import UIKit
import HandyJSON

class WQNewsModel: HandyJSON {
    var title: String?
    var image: String?
    var video: String?
    var content: String?
    var timestamp: String?
    required init() {}
}
