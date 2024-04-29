//
//  SWEBController.swift
//  ABCApp
//
//  Created by apple on 2024/4/28.
//

import UIKit

class SWEBController: AppWebViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 10.px())
        self.baseBackBtn.isHidden = true
        
        self.left3View.iconImg.image = UIImage.init(named: "icon_service_selected")
        self.left3View.setSelAction()
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
