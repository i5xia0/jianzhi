//
//
//
//
//  Created by linke50 on 8/14/20.
//  Copyright © 2020 50. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

class WQProgressHUD {
    static let shared = WQProgressHUD()
    var backgroundView: UIView?
    static func showLoading() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = COLOR_Base.S000000_10
        view.makeToastActivity(ToastPosition.center)
        WQ_WINDOW?.addSubview(view)
        shared.backgroundView = view
    }
    static func hiddenLoading() {
        shared.backgroundView?.hideToastActivity()
        dismiss()
    }
    static func showMassage(_ massage: String) {
        let view = WQ_WINDOW?.rootViewController?.view
        view!.makeToast(massage)
    }
    @objc static func dismiss() {
        shared.backgroundView?.removeFromSuperview()
    }
}
