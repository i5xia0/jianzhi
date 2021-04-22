//
//  WQBooksDetailsVC.swift
//  qh001
//
//  Created by linke50 on 4/22/21.
//

import UIKit

class WQBooksDetailsVC: WQBaseVC {

    var model: WQBookModel!
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        scroll.addSubview(imageV)
        scroll.addSubview(titleLab)
        scroll.addSubview(contentLab)
        scroll.contentSize = CGSize(width: ScreenWidth - 20, height: contentLab.bottomY)
        return scroll
    }()
    lazy var imageV: UIImageView = {
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 20, height: ADAPTWIDTH(300)))
        imageV.contentMode = .scaleAspectFit
        imageV.kf.setImage(with: URL(string: model.image!))
        return imageV
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel(frame:CGRect(x: 0, y: ADAPTWIDTH(300) + 10, width: ScreenWidth - 20, height: 30))
        lab.font = SFONT.Bold18
        lab.textColor = COLOR_Base.S303133
        lab.text = "推荐说明："
        return lab
    }()
    lazy var contentLab: UILabel = {
        let contentLab = UILabel(frame:CGRect(x: 0, y: titleLab.bottomY, width: ScreenWidth - 20, height: 0))
        contentLab.font = SFONT.PingFang16
        contentLab.textColor = COLOR_Base.S303133
        contentLab.numberOfLines = 0
        contentLab.text = model.content
        contentLab.sizeToFit()
        return contentLab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = model.title
        navBarReturn = true
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
