//
//  WQBooksVC.swift
//  qh001
//
//  Created by linke50 on 4/22/21.
//

import UIKit
import MJRefresh

private let booksCell_id = "booksCell"

class WQBooksVC: WQBaseVC {
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.width - 30)/2, height: ADAPTWIDTH(200))
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.width - 20, height: 80), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WQBooksCell", bundle: Bundle.main), forCellWithReuseIdentifier: booksCell_id)
        collectionView.backgroundColor = COLOR_Base.SF5F7FA
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        return collectionView
    }()
    
    var datas = Array<WQBookModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推荐书籍"
        navBarReturn = true
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        collectionView.mj_header = header
        collectionView.mj_header?.beginRefreshing()
    }
    
    @objc dynamic func headerRefresh(){
        LKNetworkManager.shared.getBooksList { (result) -> (Void) in
            self.collectionView.mj_header?.endRefreshing()
            let list:Array<Any> = result.data as! Array<Any>
            self.datas = list.map{WQBookModel.deserialize(from: ($0 as! Dictionary<String,Any>))!}
            self.collectionView.reloadData()
        } fail: { (error) -> (Void) in
            self.collectionView.mj_header?.endRefreshing()
            WQProgressHUD.showMassage(error)
        }
    }

}
extension WQBooksVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: booksCell_id, for: indexPath) as! WQBooksCell
        itemCell.setData(model: self.datas[indexPath.row])
        return itemCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        NavigationManager.shared.goToBooksDetailsVC(model: self.datas[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.width - 30)/2, height: ADAPTWIDTH(200))
    }
}
