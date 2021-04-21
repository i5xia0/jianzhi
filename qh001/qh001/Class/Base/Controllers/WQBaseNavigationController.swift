//
//  WQBaseNavigationController.swift
//   
//
//  Created by linke50 on 7/16/20.
//  Copyright © 2020 50. All rights reserved.
//

import UIKit

class WQBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = false
        
    }
    convenience init(rootViewController: UIViewController,isHiddenBar:Bool) {
        self.init(rootViewController: rootViewController)
        self.navigationBar.isHidden = isHiddenBar
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
