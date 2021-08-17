//
//  RegisterViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/8.
//

import UIKit

class RegisterViewController: UIViewController {

    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.gray, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return btn
    }()
    
    @objc func cancelAction(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    let registerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "注册"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    
    let usernameLabel = Tools.setUpLoginLabel("用户名")
    let usernameTextField = Tools.setUpLoginTextField("输入用户名")
    
    let passwordLabel = Tools.setUpLoginLabel("密码")
    let passwordTextField = Tools.setUpLoginTextField("输入密码")
    
    let repeatPasswordLabel = Tools.setUpLoginLabel("确认密码")
    let repeatPasswordTextField = Tools.setUpLoginTextField("再次输入密码")
    
    @objc func dismissKeyboard() {
        usernameTextField.placeholder = "输入用户名"
        passwordTextField.placeholder = "输入密码"
        repeatPasswordTextField.placeholder = "再次输入密码"
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        repeatPasswordTextField.endEditing(true)
    }
    
    let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: .normal)
        btn.backgroundColor = K.brandGreen
        btn.layer.cornerRadius = 20
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    @objc func registerAction(sender: UIButton){
        sender.showAnimation {
            self.view.endEditing(true)
            
            let userNameString = self.usernameTextField.text
            if userNameString?.count == 0 {
                CBToast.showToastAction(message: "请输入用户名或邮箱！")
                return
            }
            
            let passwordString = self.passwordTextField.text
            if passwordString?.count == 0 {
                CBToast.showToastAction(message: "请输入密码！")
                return
            }
            
            if passwordString!.count < 6 {
                CBToast.showToastAction(message: "密码至少六位！")
            }
            
            
            let confirmPasswordString = self.repeatPasswordTextField.text
            if confirmPasswordString != passwordString {
                CBToast.showToastAction(message: "两次密码输入不一致！")
                return
            }
            
            let urlString = "\(K.API2)Account/UserReg.ashx?\(K.Suffix)"
            let url = URL(string: urlString)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let postString = "\(urlString)&LoginAccount=\(userNameString!)&Password=\(passwordString!)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)

            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {print("Something went wrong")}
                if let data = data{
                    var result: WallpaperData?
                    
                    do{
                        result = try JSONDecoder().decode(WallpaperData.self, from: data)
                    }catch{
                        print(error)
                    }
                    if result?.Code! == 0 {
                        CBToast.showToastAction(message: "注册成功！")
                        DispatchQueue.main.sync {
                            self.dismiss(animated: true, completion: nil)
                        }
        
                    }else {
                        CBToast.showToastAction(message: (result?.Description)! as NSString)
                        return
                    }
                }
            }
            task.resume()
        }
        }
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.delegate = self
        cancelButton.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerAction(sender:)), for: .touchUpInside)
    
        

        view.addSubview(cancelButton)
        view.addSubview(registerLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(repeatPasswordLabel)
        view.addSubview(repeatPasswordTextField)

        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(12)
            make.left.equalTo(view).offset(20)
        }
        
        registerLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(16)
        }
        
        usernameLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(24)
            make.top.equalTo(registerLabel.snp_bottomMargin).offset(100)
        }
        
        usernameTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(usernameLabel.snp_bottomMargin).offset(-4)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
        }
        
        passwordLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(usernameTextField.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(24)
        }
        passwordTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(passwordLabel.snp_bottomMargin).offset(-4)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
        }

        
        repeatPasswordLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(24)
        }
        
        repeatPasswordTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(repeatPasswordLabel.snp_bottomMargin).offset(-4)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
        }
        
        registerButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(repeatPasswordTextField.snp_bottomMargin).offset(30)
            
            make.right.equalTo(view).offset(-24)
        }

        

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

      
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == usernameTextField {
            usernameTextField.placeholder = ""
            passwordTextField.placeholder = "输入密码"
            repeatPasswordTextField.placeholder = "再次输入密码"
            usernameTextField.addLine(position: .bottom, color: K.brandPink, width: 3.0)
        }else if textField == passwordTextField{
            passwordTextField.placeholder = ""
            usernameTextField.placeholder = "输入用户名"
            repeatPasswordTextField.placeholder = "再次输入密码"
            passwordTextField.addLine(position: .bottom, color: K.brandPink, width: 3.0)
        }else {
            repeatPasswordTextField.placeholder = ""
            passwordTextField.placeholder = "输入密码"
            usernameTextField.placeholder = "输入用户名"
            repeatPasswordTextField.addLine(position: .bottom, color: K.brandPink, width: 3.0)
        }

        

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTextField.addLine(position: .bottom, color: .black, width: 3.0)
        }else if textField == passwordTextField{
            passwordTextField.addLine(position: .bottom, color: .black, width: 3.0)
        }else{
            repeatPasswordTextField.addLine(position: .bottom, color: .black, width: 3.0)
        }
        
      
        
        

    }
}
