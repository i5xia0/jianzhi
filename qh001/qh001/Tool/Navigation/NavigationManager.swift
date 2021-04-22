//
//  NavigationManager.swift
//  qh001
//
//  Created by linke50 on 4/10/21.
//

import UIKit

class NavigationManager: NSObject {
    static let shared = NavigationManager()

    var mainNav: UINavigationController? = {
        var nav = WQ_AppDelegate?.mainNavController
        for  controller in nav!.viewControllers {
            if controller.isKind(of: UINavigationController.classForCoder()) {
                nav = (controller as! UINavigationController)
                return nav
            }
        }
        if ((nav?.presentedViewController) != nil) && ((nav?.presentedViewController?.isKind(of: UINavigationController.classForCoder())) != nil) {
            return (nav?.presentedViewController as! UINavigationController)
        }
        return nav
    }()

    static func currentViewController() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return currentViewController(vc)
    }
    
    static func currentViewController(_ vc :UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presentVC = vc?.presentedViewController {
            return currentViewController(presentVC)
        }
        else if let tabVC = vc as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return currentViewController(selectVC)
            }
            return nil
        }
        else if let naiVC = vc as? UINavigationController {
            return currentViewController(naiVC.visibleViewController)
        }
        else {
            return vc
        }
    }
}

//MARK: 页面跳转
extension NavigationManager {
    //登录
    func goToLogin() {
        let loginVC = SPLoginVC()
        self.mainNav!.pushViewController(loginVC, animated: true)
    }
    //联系客服
    func goToServiceChat(){
        let chatVC = SPChatVC()
        chatVC.title = "客服"
        self.mainNav!.pushViewController(chatVC, animated: true)
    }
    //反馈意见
    func goToFeedback(){
        let feedVC = WQFeedbackVC()
        feedVC.title = "反馈意见"
        self.mainNav!.pushViewController(feedVC, animated: true)
    }
    //微视频
    func goToVideoVC(){
        let videoVC = WQVideoVC()
        self.mainNav!.pushViewController(videoVC, animated: true)
    }
    //微视频详情
    func goToVideoPlayVC(video:WQNewsModel){
        let videoPlayVC = WQVideoPlayVC()
        videoPlayVC.video = video
        self.mainNav!.pushViewController(videoPlayVC, animated: true)
    }
    //快讯
    func goToNewsVC(){
        let newsVC = WQNewsVC()
        self.mainNav!.pushViewController(newsVC, animated: true)
    }
    //资讯详情
    func goToNewDetailsVC(news:WQNewsModel){
        let newDetailsVC = WQNewDetailsVC()
        newDetailsVC.news = news
        self.mainNav!.pushViewController(newDetailsVC, animated: true)
    }
    //资讯详情
    func goToCommentsVC(model:WQBSSModel,bssVC:WQBSSVC){
        let commentsVC = WQCommentsVC()
        commentsVC.model = model
        commentsVC.delegate = bssVC
        self.mainNav!.pushViewController(commentsVC, animated: true)
    }
    //推荐书籍
    func goToBooksVC(){
        let booksVC = WQBooksVC()
        self.mainNav!.pushViewController(booksVC, animated: true)
    }
    //推荐书籍详情
    func goToBooksDetailsVC(model:WQBookModel){
        let booksDatailsVC = WQBooksDetailsVC()
        booksDatailsVC.model = model
        self.mainNav!.pushViewController(booksDatailsVC, animated: true)
    }
    //发布页
    func presentPostVC(){
        let PostVC = WQPostVC()
        self.mainNav!.present(PostVC, animated: true, completion: nil)
    }
    //行情详情
    func gotoMarketDetailsVC(model:WQMarketModel){
        let martketDetailsVC = WQMatketDetailsVC()
        martketDetailsVC.market = model
        self.mainNav!.pushViewController(martketDetailsVC, animated: true)
    }
    
    //行情详情
    func showPostAlert(){
        let alertController = UIAlertController.init(title: nil, message: "发布成功，我们将审核后展示", preferredStyle: .alert);
        alertController.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: { (action) in
        }))
        self.mainNav!.present(alertController, animated: true)
    }
    
}
