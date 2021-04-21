//
//  SPChatHeaderViewCell.swift
//  ShowPay
//
//  Created by linke50 on 7/29/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class SPChatHeaderViewCell: UITableViewCell {
    
    var rowHeight:CGFloat = 30.0
    var label:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.backgroundColor = COLOR_Base.SF5F7FA
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getHeight() -> CGFloat
    {
        return 30.0
    }
    
    func setDate(_ value:Date)
    {
       
        self.rowHeight  = 30.0
        var timeInterval = value.timeIntervalSinceNow
        let dateFormatter =  DateFormatter()
        timeInterval = -timeInterval
        if timeInterval/60 > 60 {
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        }else {
            dateFormatter.dateFormat = "HH:mm"
        }
        let text =  dateFormatter.string(from: value)
        
        if (self.label != nil)
        {
            self.label.text = text
            return
        }
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.label = UILabel(frame:CGRect(x: CGFloat(0), y: CGFloat(0), width: self.frame.size.width, height: rowHeight))
        self.label.text = text
        self.label.font = SFONT.PingFang10
        
        self.label.textAlignment = NSTextAlignment.center
        self.label.shadowOffset = CGSize(width: 0, height: 1)
        self.label.shadowColor = UIColor.white
        
        self.label.textColor = COLOR_Base.SBFC2CC
        
        self.label.backgroundColor = UIColor.clear
        
        self.addSubview(self.label)
    }
    //让单元格宽度始终为屏幕宽
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.width = UIScreen.main.bounds.width
            super.frame = frame
        }
    }
}

