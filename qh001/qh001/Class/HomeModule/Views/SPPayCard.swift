//
//  SPPayCard.swift
//  ShowPay
//
//  Created by linke50 on 7/27/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit

private let cardCell_id = "cardCell"

class Card {
    var name: String? // "BTC","BSV","BCH"
    var virtualCoin: String?
    var virtualCoinBalance: Double?
    var currency: String?
    var currencyBalance: Double?
}

class SPPayCard: UIView {
    
    var myTimer:Timer?
    
    var dataArray = [["name":"first","pic":"1.jpeg"],["name":"second","pic":"2.jpeg"],["name":"third","pic":"3.jpeg"]]
    
    lazy var layout: CardFlowLayout = {
        let layout = CardFlowLayout()
        layout.itemSize = CGSize(width: width - 40, height: ADAPTWIDTH(150))
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 10, width: width, height: ADAPTWIDTH(150)), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "SPPayCardCell", bundle: Bundle.main), forCellWithReuseIdentifier: cardCell_id)
        collectionView.backgroundColor = COLOR_Base.SF5F7FA
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        return collectionView
    }()
    
    lazy var panScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x:15,y: 10,width: width - 30,height: ADAPTWIDTH(150)))
        scrollView.isHidden = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(dataArray.count), height: 0.0)
        self.collectionView.addGestureRecognizer(scrollView.panGestureRecognizer)
        self.collectionView.panGestureRecognizer.isEnabled = false
        return scrollView
    }()
    lazy var pageControl: SPPageControl = {
        let pageControl = SPPageControl(frame: CGRect.init(x: 0, y:height - 30, width: width, height: 20))//初始化PageControl
        pageControl.numberOfPages = self.dataArray.count//总页数
        pageControl.localCurrentPage = 0
        pageControl.localPointSpace = 4//间距
        pageControl.pointSize = CGSize.init(width: 5, height: 5)//点的size
        pageControl.clickPoint { (index) in//圆点的点击事件
        }
        return pageControl
    }()
    
    convenience init(frame: CGRect,nameStringsGroup:[String]?) {
        self.init(frame: frame)
        collectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        addSubview(pageControl)
        addSubview(panScrollView)
        self.myTimer = Timer.init(timeInterval: 2.0,target: self,selector: #selector(timerAction),userInfo: nil,repeats: true)
        RunLoop.main.add(self.myTimer!,forMode: RunLoop.Mode.default)
            
    }
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    @objc func timerAction(){
        if let indexPath = collectionView.indexPathsForVisibleItems.last {
            let nextPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
            collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
        }
      }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setContentOffset() {
        panScrollView.setContentOffset(CGPoint(x: panScrollView.width * CGFloat(1), y: 0.0), animated: false)
        collectionView.setContentOffset(CGPoint(x: panScrollView.width * CGFloat(1), y: 0.0), animated: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SPPayCard: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCell_id, for: indexPath) as! SPPayCardCell
        return cardCell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == panScrollView {
            collectionView.contentOffset = panScrollView.contentOffset
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //根据自己的大小计算
        let i = Int(scrollView.contentOffset.x) / Int(panScrollView.width)
        UIView.animate(withDuration: 0.3) {
            self.pageControl.currentPage = i
        }
    }
}

class CardFlowLayout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        super.prepare()
        scrollDirection = UICollectionView.ScrollDirection.horizontal
        minimumLineSpacing = 10.0
        sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //根据当前滚动进行对每个cell进行缩放
        //首先获取 当前rect范围内的 attributes对象
        let original = super.layoutAttributesForElements(in: rect)
        let array: [UICollectionViewLayoutAttributes] = NSArray(array: original!, copyItems: true) as! [UICollectionViewLayoutAttributes]
        let ScaleFactor: CGFloat = 0.001//缩放因子
        //计算缩放比  首先计算出整体中心点的X值 和每个cell的中心点X的值
        //用着两个x值的差值 ，计算出绝对值
        //colleciotnView中心点的值
        let centerX =  (collectionView?.contentOffset.x)! + (collectionView?.bounds.size.width)!/2
        //循环遍历每个attributes对象 对每个对象进行缩放
        for attr in array {
            //计算每个对象cell中心点的X值
            let cell_centerX = attr.center.x
            
            //计算两个中心点的便宜（距离）
            //距离越大缩放比越小，距离小 缩放比越大，缩放比最大为1，即重合
            let distance = abs(cell_centerX-centerX)
            let scale:CGFloat = 1/(1+distance*ScaleFactor)
            attr.transform3D = CATransform3DMakeScale(1.0, scale, 1.0)
            
        }
        
        return array
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let visibleX = proposedContentOffset.x
        let visibleY = proposedContentOffset.y
        let visibleW = collectionView?.bounds.size.width
        let visibleH = collectionView?.bounds.size.height
        //获取可视区域
        let targetRect = CGRect(x: visibleX, y: visibleY, width: visibleW!, height: visibleH!)
        //中心点的值
        let centerX = proposedContentOffset.x + (collectionView?.bounds.size.width)!/2
        //获取可视区域内的attributes对象
        let attrArr = super.layoutAttributesForElements(in: targetRect)!
        //如果第0个属性距离最小
        var min_attr = attrArr[0]
        for attributes in attrArr {
            if (abs(attributes.center.x-centerX) < abs((min_attr as AnyObject).center.x-centerX)) {
                min_attr = attributes
            }
        }
        //计算出距离中心点 最小的那个cell 和整体中心点的偏移
        let ofsetX = (min_attr as AnyObject).center.x - centerX
        return CGPoint(x: proposedContentOffset.x+ofsetX, y: proposedContentOffset.y)
    }
    
    
    
}
