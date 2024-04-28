//
//  RootTabBarVC.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

class RootTabBarVC: UITabBarController, UITabBarControllerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true;
        self.setUpChildVC()
        self.delegate = self;

        // Do any additional setup after loading the view.
    }
    
    func setUpChildVC()  {
        let webVc = SWEBController()
        webVc.urlStr = ApiPrefix + "/feebleWaved"
        webVc.type1 = "tab"
        self.setChileViewController(vc: HomeVC())
        self.setChileViewController(vc: MessageVC())
        self.setChileViewController(vc: webVc)
        self.setChileViewController(vc: ProfileVC())
    }
    
    func setChileViewController(vc:UIViewController) {        
        self.addChild(BaseNC.init(rootViewController: vc))
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
