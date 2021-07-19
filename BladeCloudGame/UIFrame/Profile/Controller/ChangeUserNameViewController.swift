//
//  ChangeUserNameViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import UIKit

class ChangeUserNameViewController: UIViewController {
    
    let usernameTextField: UserNameTextField = {
        let tf = UserNameTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 10
        tf.backgroundColor = K.brandLightGray
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return tf
    }()
    
    let confirmButton = Tools.setUpButton("确认", K.brandGreen, 15)
    
    @objc func confirmAction(sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "更新用户名"
        
        usernameTextField.delegate = self
        
        confirmButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        confirmButton.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        
        view.addSubview(usernameTextField)
        view.addSubview(confirmButton)
        
        usernameTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(16)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }

        confirmButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(usernameTextField.snp_bottomMargin).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
    }
    
}

extension ChangeUserNameViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if usernameTextField.text != "" {
            User.defaults.setValue(usernameTextField.text, forKey: "Name")
            CBToast.showToastAction(message: "更新成功")
        }
    }
}
class UserNameTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
