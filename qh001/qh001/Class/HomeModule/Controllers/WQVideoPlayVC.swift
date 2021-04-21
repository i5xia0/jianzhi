//
//  WQVideoPlayVC.swift
//  qh001
//
//  Created by linke50 on 4/15/21.
//

import UIKit
import ZFPlayer




class WQVideoPlayVC: WQBaseVC {

    
    var video: WQNewsModel!
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable  = false
        textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        textView.font = SFONT.PingFang15
        textView.text = video.content
        view.addSubview(textView)
        return textView
    }()
    lazy var videoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ADAPTWIDTH(200)))
        self.view.addSubview(view)
        return view
    }()
    lazy var playerManager: ZFAVPlayerManager = {
        let playerManager = ZFAVPlayerManager()
        return playerManager
    }()
    lazy var player: ZFPlayerController = {
        let player = ZFPlayerController(playerManager: playerManager, containerView: videoView)
        player.controlView = controlView
        player.pauseWhenAppResignActive = false
        return player
    }()
    lazy var controlView: ZFPlayerControlView = {
        let controlView = ZFPlayerControlView()
        controlView.fastViewAnimated = false
        controlView.prepareShowLoading = true
        controlView.prepareShowControlView = false
        controlView.customDisablePanMovingDirection = true
        return controlView
    }()
    
    lazy var titleView: UIView = {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        let label = UILabel()
        label.font = SFONT.Bold18
        label.text = video.title
        titleView.addSubview(label)
        label.sizeToFit()
        titleView.backgroundColor = .white
        label.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(label.width)
            make.height.equalTo(label.height)
        }
        view.addSubview(titleView)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视频详情"
        navBarReturn = true
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(ADAPTWIDTH(200))
        }
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(ADAPTWIDTH(40))
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.player.assetURL = URL(string: video.video!)!
        self.controlView.showTitle(video.title, coverURLString: "", fullScreenMode: .landscape)
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
