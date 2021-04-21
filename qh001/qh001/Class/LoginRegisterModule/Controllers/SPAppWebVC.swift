//
//  SPAppWebVC.swift
//  ShowPay
//
//  Created by linke50 on 7/21/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class SPAppWebVC: WQBaseVC {

    var urlString: String?
    
    lazy private var progressView: UIProgressView = {
        let progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: ScreenWidth, height: 2))
        progressView.tintColor = UIColor.green      // 进度条颜色
        progressView.trackTintColor = COLOR_Base.SF5F7FA // 进度条背景色
        view.addSubview(progressView)
        return progressView
    }()
    
    lazy private var webView: WKWebView = {
        //创建配置对象
        let configuration = WKWebViewConfiguration()
        let web = WKWebView.init(frame: CGRect.zero,configuration: configuration)
        web.navigationDelegate = self
        web.uiDelegate = self
        let url: URL = URL(string: urlString!)!
        let request = URLRequest(url: url)
        web.load(request)
        view.addSubview(web)
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        navBar.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.right.equalToSuperview()
//            make.left.equalToSuperview()
//            make.height.equalTo(NavgationHeight)
//        }
        progressView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(2)
        }
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    deinit {
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
    }
}

extension SPAppWebVC {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //  加载进度条
        if keyPath == "estimatedProgress"{
            if (self.webView.estimatedProgress)  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                    self.progressView.snp.updateConstraints { (make) in
                        make.height.equalTo(0)
                    }
                })
            }else {
                self.progressView.snp.updateConstraints { (make) in
                    make.height.equalTo(2)
                }
                progressView.alpha = 1.0
                progressView.setProgress(Float((self.webView.estimatedProgress) ), animated: true)
            }
        }
    }
}

extension SPAppWebVC: WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler  {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       
    }
    //获取js alert事件
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert);
        alertController.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
            print("点击了。。。。");
            completionHandler();
        }))
        self.present(alertController, animated: true) {
            print("gone。。。。");
        }
    }

       
}
