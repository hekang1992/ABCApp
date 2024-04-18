//
//  ViewController.swift
//  ABCApp
//
//  Created by Boris on 2024/1/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        var doc = AppAFNetManager.getPublicParamsAction();
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var webVC = AppWebViewVC()
        webVC.urlStr = "http://147.139.168.226:8093/test?url=https://www.baidu.com&emaill=757712617@qq.com"
        self.navigationController?.pushViewController(webVC, animated: true);
        
    }


}

