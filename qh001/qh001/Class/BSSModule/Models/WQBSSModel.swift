//
//  WQBSSModel.swift
//  qh001
//
//  Created by linke50 on 4/21/21.
//

import UIKit
import HandyJSON

class WQBSSModel: HandyJSON {
    var id:Int?
    var avatars: String?
    var name: String?
    var title: String?
    var image: String?
    var video: String?
    var content: String?
    var timestamp: String?
    var like: Int = 0
    required init() {}
}
