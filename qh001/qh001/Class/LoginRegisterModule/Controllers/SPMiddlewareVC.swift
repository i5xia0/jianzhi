//
//  SPMiddlewareVC.swift
//  ShowPay
//
//  Created by linke50 on 8/13/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit
import WebKit

class SPMiddlewareVC: UIViewController {
    
    lazy var web: WKWebView = {
        return self.view
        }() as! WKWebView
    
    override func loadView() {
        //创建配置对象
        let configuration = WKWebViewConfiguration()
        //为WKWebViewController设置偏好设置
        let preference = WKPreferences()
        configuration.preferences = preference
        let userContent = WKUserContentController()
        configuration.userContentController = userContent
        configuration.allowsInlineMediaPlayback = true
        //允许native与js交互
        preference.javaScriptEnabled = true
        self.view = WKWebView.init(frame: CGRect.zero,configuration: configuration)
        web.navigationDelegate = self
        web.uiDelegate = self
        var path = Bundle.main.bundlePath
        path = path + "/index.html"
        print(path)
        let url: URL = URL(fileURLWithPath: path)
        let request = URLRequest(url: url)
        web.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.web.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "初始钱包", style: .plain, target: self, action: #selector(imageBarButtonItemMethod))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "生成TX", style: .plain, target: self, action: #selector(makeTX))
    }
    @objc func imageBarButtonItemMethod() {
        
    }
     @objc func makeTX() {
    //        'xprv9xmXXvnpKZzNUq3b9rHXRoNnrT3Ck8nZ4YJGBSFpLYgMWTsbtJ1wWxVUDx4saXnfsYw7gcb34bw2hya8w4sLa2xwu6LMErhH6mdVDxo2qcQ'
        let testJS = "makeTx('\("19Z83M3wHujypdp4yGx5Y1ZJ3Xi86EfBn1")')"
            self.web.evaluateJavaScript(testJS) { (item, error) in
                       print(item as Any,error as Any)
                   }
        }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.title = self.web.title
    }
    deinit {
        self.web.removeObserver(self, forKeyPath: "title")
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
extension SPMiddlewareVC: WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("来了")
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
