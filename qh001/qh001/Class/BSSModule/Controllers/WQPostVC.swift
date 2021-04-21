//
//  WQPostVC.swift
//  qh001
//
//  Created by linke50 on 4/16/21.
//

import UIKit

private let postImageCell_id = "postImageCell"

class WQPostVC: UIViewController {

    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textView: UITextView!
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.width - 90.0)/4, height: (view.width - 90.0)/4)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 10.0
//        layout.minimumInteritemSpacing = 10.0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.width - 30, height: 200), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WQPostImageCell", bundle: Bundle.main), forCellWithReuseIdentifier: postImageCell_id)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var submitButton: UIButton = {
        let submitButton = UIButton(type: UIButton.ButtonType.custom)
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderColor = COLOR_Base.SEDEFF2.cgColor
        submitButton.layer.borderWidth = 1
        view.addSubview(submitButton)
        submitButton.setTitle("发布", for: UIControl.State.normal)
        submitButton.setTitleColor(COLOR_Base.SBFC2CC, for: UIControl.State.disabled)
        submitButton.setBackgroundImage(UIImage.imageFromColor(color: COLOR_Base.SEAB300, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.normal)
        submitButton.setBackgroundImage(UIImage.imageFromColor(color: .white, viewSize: CGSize(width: 50, height: 50)), for: UIControl.State.disabled)
        submitButton.isEnabled = false
        submitButton.titleLabel?.font = SFONT.System16
        submitButton.addTarget(self, action: #selector(submitButtonClick), for: UIControl.Event.touchUpInside)
        return submitButton
    }()
    lazy var promptView: UIView = {
        let promptView = UIView()
        let label = UILabel()
        label.font = SFONT.PingFang10
        label.numberOfLines = 0
        label.text = "提示：严禁发布色情、政治敏感词、赌博等违法文字，一经发现，立刻封号！"
        promptView.addSubview(label)
        label.textColor = .red
        label.width = ScreenWidth - 40
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 5, width: ScreenWidth - 40, height: label.height)
        promptView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: label.height + 10)
        view.addSubview(promptView)
        return promptView
    }()
    var itemSiez:CGSize = CGSize(width: (ScreenWidth - 90.0)/4, height: (ScreenWidth - 90.0)/4)
    var images: Array<UIImage> = Array()
    var canAdd:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainerInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.cornerAll(5)
        images.append(UIImage(named: "addimage")!)
        promptView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-(30 + SafeAreaBottomHeight))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(promptView.height)
        }
        submitButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(promptView.snp.top).offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.bottom.equalTo(submitButton.snp.top).offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        textView.becomeFirstResponder()
    }

    @objc dynamic func submitButtonClick() {
        WQProgressHUD.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            WQProgressHUD.hiddenLoading()
            self.dismiss(animated: true, completion: nil)
            NavigationManager.shared.showPostAlert()
        }
    }
    @objc dynamic func cancelImageButtonClick(sender:UIButton) {
        if self.canAdd == false && self.images.count == 9 {
            self.images.append(UIImage(named: "addimage")!)
            self.canAdd = true
        }
        self.images.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
    
    lazy var setting: Settings = {
        let setting = Settings()
        // Mark: 提供给外部，让外部决定需要什么资源 （照片 视频 音频） 注：默认有照片视频
        setting.fetch.assets.supportedMediaTypes = [.image]
        // Mark: 是否展示3dtouch图片
        setting.fetch.preview.showLivePreview = true
        // Mark: 相册cell的高度
        setting.list.albumsCellH = 58
//        setting.fetch.preview.allowCrop = true
        // Mark: cell之间的间隙大小
        setting.list.spacing = 2
        // Mark:cell一行有多少个
        setting.list.cellsPerRow = {(verticalSize, horizontalSize) in
            switch (verticalSize, horizontalSize) {
            case (.compact, .regular):
                return 4
            case (.compact, .compact):
                return 5
            case (.regular, .regular):
                return 7
            default:
                return 4
            }
        }
        // Mark: 主题背景颜色 默认白色
        setting.theme.backgroundColor = .white
        // Mark: 主题导航栏颜色 默认白色
        setting.theme.navigationBarColor = .white
        // Mark:  可以选择的最多张数 默认9张
        setting.selection.max = 9
        // Mark:  可以选择最少的张数 默认为1张
        setting.selection.min = 1
        
        return setting
    }()
}
extension WQPostVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: postImageCell_id, for: indexPath) as! WQPostImageCell
        itemCell.imageV.image = self.images[indexPath.row]
        if self.canAdd && indexPath.row == self.images.count - 1 {
            itemCell.cancelBtn.isHidden = true
        }else {
            itemCell.cancelBtn.isHidden = false
            itemCell.cancelBtn.tag = indexPath.row
            itemCell.cancelBtn.addTarget(self, action: #selector(cancelImageButtonClick), for: UIControl.Event.touchUpInside)
        }
        return itemCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if self.canAdd && indexPath.row == self.images.count - 1 {
                LRImagePicker.go(settings:setting,finish: { (assets, isOriginal) in
                    self.images.removeAll()
                    for asset in assets {
                        self.images.append(WQPHAssetToImageTool.PHAssetToImage(asset: asset, size: self.itemSiez))
                    }
                    if assets.count != 9 {
                        self.images.append(UIImage(named: "addimage")!)
                        self.canAdd = true
                    }else {
                        self.canAdd = false
                    }
                    print("\(assets)\(isOriginal)")
                    self.collectionView.reloadData()
                })
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSiez
    }
    
}
extension WQPostVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
               textView.resignFirstResponder()
        }
        let changeStr = NSMutableString(string: textView.text ?? "")
        changeStr.replaceCharacters(in: range, with: text)
        if changeStr.length == 0 {
            self.submitButton.isEnabled = false
        }else {
            self.submitButton.isEnabled = true
        }
        return true
    }
}
