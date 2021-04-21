//
//  WQSlipMenuView.swift
//  qh001
//
//  Created by linke50 on 4/19/21.
//

import UIKit


protocol SlipMenuDelegate {
    func selectedMenu(_ number:String)-> Void
}

class WQSlipMenuView: UIView {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: height)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(WQSlipMenuCell.self, forCellWithReuseIdentifier: slipMenuCell_id)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        return collectionView
    }()
    
    lazy var lineView: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: itemW, height: 1))
        line.cornerAll(1)
        line.backgroundColor = lineColor
        addSubview(line)
        return line
    }()
    var delegate: SlipMenuDelegate!
    
    var lineColor: UIColor? = .white
    var titles: Array<String>!
    var currentIndex: Int?
    var itemW: CGFloat = ScreenWidth/8
    
    init(frame: CGRect,titles:Array<String>) {
        super.init(frame: frame)
        self.titles = titles
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(1)
            make.width.equalTo(width/8 - 20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private let slipMenuCell_id = "slipMenuCell"
extension WQSlipMenuView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: slipMenuCell_id, for: indexPath) as! WQSlipMenuCell
        itemCell.titleLab.text = titles[indexPath.row]
        print(titles[indexPath.row])
        itemCell.titleLab.textColor = .white
        return itemCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
        UIView.animate(withDuration: 1) { [self] in
            self.lineView.snp.updateConstraints { (make) in
                make.left.equalTo(indexPath.row*Int(itemW) + 10)
            }
        }
        if indexPath.row != 7 {
            delegate.selectedMenu(String(indexPath.row + 1))
        }else {
            delegate.selectedMenu("7")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemW, height: height)
    }
}


