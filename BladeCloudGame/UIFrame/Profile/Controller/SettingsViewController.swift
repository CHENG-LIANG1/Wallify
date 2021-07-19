//
//  SettingsViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let logOutButton = Tools.setUpButton("退出", K.brandRed, 22)
    func logout(alert: UIAlertAction!){
        User.defaults.removeObject(forKey: "Name")
        User.defaults.removeObject(forKey: "Favorites")
        CBToast.showToastAction(message: "Logged out")
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func logOutAction(sender: UIButton){
        sender.showAnimation {
            let alert = UIAlertController.init(title: "退出", message: "确定退出?", preferredStyle:.alert)
            let action1 = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            let action2 = UIAlertAction.init(title: "退出", style: .default, handler: self.logout)
            
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.addTarget(self, action: #selector(logOutAction(sender:)), for: .touchUpInside)

        view.addSubview(logOutButton)
        view.backgroundColor = .white
        
        logOutButton.backgroundColor = K.brandRed
        logOutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logOutButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(16)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
    }
}
