//
//  SPChatTableView.swift
//  ShowPay
//
//  Created by linke50 on 7/29/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

/*
 数据提供协议
 */
protocol ChatDataSource
{
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( _ tableView:SPChatTableView) -> Int
    /*返回某一行的内容*/
    func chatTableView(_ tableView:SPChatTableView, dataForRow:Int)-> MessageItem
}

enum ChatBubbleTypingType
{
    case nobody
    case me
    case somebody
}

private let headerCell_id = "HeaderCell"
private let chatCell_id = "ChatCell"
class SPChatTableView: UITableView {
    //用于保存所有消息
    var bubbleSection:NSMutableArray!
    //数据源，用于与 ViewController 交换数据
    var chatDataSource:ChatDataSource!
    
    var  snapInterval:TimeInterval!
    var  typingBubble:ChatBubbleTypingType!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        //the snap interval in seconds implements a headerview to seperate chats
        self.snapInterval = TimeInterval(60 * 60 * 24) //one day
        self.typingBubble = ChatBubbleTypingType.nobody
        self.bubbleSection = NSMutableArray()
        
        super.init(frame:frame,  style:style)
        
        self.backgroundColor = COLOR_Base.SF5F7FA
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        self.register(SPChatHeaderViewCell.self, forCellReuseIdentifier: headerCell_id)
        self.register(SPChatTableViewCell.self, forCellReuseIdentifier: chatCell_id)
    }
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bubbleSection = NSMutableArray()
        var count =  0
        if ((self.chatDataSource != nil))
        {
            count = self.chatDataSource.rowsForChatTable(self)
            
            if(count > 0)
            {
                let bubbleData =  NSMutableArray(capacity:count)
                
                for i in 0 ..< count
                {
                    let object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleData.add(object)
                }
                bubbleData.sort(comparator: sortDate)
                
                var last =  ""
                
                var currentSection = NSMutableArray()
                // 创建一个日期格式器
                let dformatter = DateFormatter()
                // 为日期格式器设置格式字符串
                dformatter.dateFormat = "dd"
                
                for i in 0 ..< count
                {
                    let data =  bubbleData[i] as! MessageItem
                    // 使用日期格式器格式化日期，日期不同，就新分组
                    let datestr = dformatter.string(from: data.date as Date)
                    if (datestr != last)
                    {
                        currentSection = NSMutableArray()
                        self.bubbleSection.add(currentSection)
                    }
                    (self.bubbleSection[self.bubbleSection.count-1] as AnyObject).add(data)
                    
                    last = datestr
                }
            }
        }
        super.reloadData()
        
        //滑向最后一部分
        let secno = self.bubbleSection.count - 1
        if secno >= 0 {
            let indexPath =  IndexPath(row:(self.bubbleSection[secno] as AnyObject).count,section:secno)
            self.scrollToRow(at: indexPath,at:UITableView.ScrollPosition.bottom,animated:true)
        }
        
    }
    
    //按日期排序方法
    func sortDate(_ m1: Any, m2: Any) -> ComparisonResult {
        if((m1 as! MessageItem).date.timeIntervalSince1970 < (m2 as! MessageItem).date.timeIntervalSince1970)
        {
            return ComparisonResult.orderedAscending
        }
        else
        {
            return ComparisonResult.orderedDescending
        }
    }
    
    func scrollToBottom(_ isReload:Bool) {
        if (self.bubbleSection.count >= 1) {
            if isReload { super.reloadData()}
            let secno = self.bubbleSection.count - 1
            let indexPath =  IndexPath(row:(self.bubbleSection[secno] as AnyObject).count,section:secno)
            self.scrollToRow(at: indexPath,at:UITableView.ScrollPosition.bottom,animated:false)
        }
    }
}

extension SPChatTableView: UITableViewDelegate, UITableViewDataSource{
    //第一个方法返回分区数
    func numberOfSections(in tableView:UITableView)->Int {
        var result = self.bubbleSection.count
        if (self.typingBubble != ChatBubbleTypingType.nobody)
        {
            result += 1;
        }
        return result;
    }
    
    //返回指定分区的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section >= self.bubbleSection.count)
        {
            return 1
        }
        return (self.bubbleSection[section] as AnyObject).count+1
    }
    
    //用于确定单元格的高度，如果此方法实现得不对，单元格与单元格之间会错位
    func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath)
        -> CGFloat {
            // Header
            if (indexPath.row == 0)
            {
                return SPChatHeaderViewCell.getHeight()
            }
            let section  =  self.bubbleSection[indexPath.section] as! NSMutableArray
            let data = section[indexPath.row - 1]
            
            let item =  data as! MessageItem
            let height  =  max(item.view.frame.size.height + 10, 50) + 10
            return height
    }
    
    //返回自定义的 TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            // Header based on snapInterval
            if (indexPath.row == 0)
            {
                let hcell =  tableView.dequeueReusableCell(withIdentifier: headerCell_id) as! SPChatHeaderViewCell
                let section =  self.bubbleSection[indexPath.section] as! NSMutableArray
                let data = section[indexPath.row] as! MessageItem
                hcell.setDate(data.date)
                return hcell
            }
            // Standard
            let section =  self.bubbleSection[indexPath.section] as! NSMutableArray
            let data = section[indexPath.row - 1]
            let cell =  SPChatTableViewCell.init(data: data as! MessageItem, reuseIdentifier: chatCell_id)
            return cell
    }
}
