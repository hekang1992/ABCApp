//
//  AlertDescViewController.swift
//  ABCApp
//
//  Created by apple on 2024/4/1.
//

import UIKit

class AlertDescViewController: BaseVC {
    
    var productId:String = ""
    var type: String = ""
    
    lazy var alertDescView: AlertDescView = {
        let alertDescView = AlertDescView()
        return alertDescView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(alertDescView)
        alertDescView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        alertDescView.block1 = { [weak self] in
            let nextVc = AlertNextViewController()
            nextVc.productId = self?.productId ?? ""
            nextVc.type = self?.type ?? ""
            self?.navigationController?.pushViewController(nextVc, animated: true)
        }
        alertDescView.block2 = { [weak self] in
            self?.backClick()
        }
    }
    
    override func backClick() {
        
        let alert = UIAlertController(title: "Are you sure you want to leave?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(cancelAction)
        let doneAction = UIAlertAction(title: "Give Up", style: .destructive) { action in
            // Handle continue action if needed
        }
        alert.addAction(doneAction)
        self.present(alert, animated: true, completion: nil)
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
