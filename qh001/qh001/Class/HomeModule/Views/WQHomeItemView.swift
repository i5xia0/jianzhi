//
//  WQHomeItemView.swift
//  qh001
//
//  Created by linke50 on 4/14/21.
//

import UIKit

private let homeItemCell_id = "homeItemCell"

class WQHomeItemView: UIView {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (width - 30)/2, height: 100)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: 110), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WQHomeItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: homeItemCell_id)
        collectionView.backgroundColor = COLOR_Base.SF5F7FA
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        return collectionView
    }()
    var datas: Array<[String:String]> = [["logo":"\u{e7d4}","name":"微视频"],
                                         ["logo":"\u{e62e}","name":"快讯"]]
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension WQHomeItemView: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: homeItemCell_id, for: indexPath) as! WQHomeItemCell
        itemCell.item = self.datas[indexPath.row]
        return itemCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row == 0{
            NavigationManager.shared.goToVideoVC()
        }else {
            NavigationManager.shared.goToNewsVC()
        }
    }
}
