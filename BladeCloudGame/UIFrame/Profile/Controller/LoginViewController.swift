//
//  LoginViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/8.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController {

    
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
    
    let loginLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "登录"
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    
    let usernameLabel = Tools.setUpLoginLabel("用户名")
    let usernameTextField = Tools.setUpLoginTextField("输入用户名")
    
    let passwordLabel = Tools.setUpLoginLabel("密码")
    let passwordTextField = Tools.setUpLoginTextField("输入密码")
    
    @objc func dismissKeyboard() {
        usernameTextField.placeholder = "输入用户名"
        passwordTextField.placeholder = "输入密码"
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = K.brandGreen
        btn.layer.cornerRadius = 20
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    let loadingView = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 2, width: 100, height: 50), type: .lineScale, color: K.brandPink, padding: 1.0)

    var loginManager = LoginManager()
    @objc func loginAction(sender: UIButton){
        
        sender.showAnimation { [self] in
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
            loadingView.startAnimating()
            loginManager.getUserData(userNameString!, passwordString!)
            loadingView.stopAnimating()

            
        }
    }
    
    let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("创建一个新账号", for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = K.brandGreen.cgColor
        btn.layer.cornerRadius = 25
        btn.setTitleColor(K.brandGreen, for: .normal)
        btn.widthAnchor.constraint(equalToConstant: K.screenWidth - 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    @objc func registerAction(sender: UIButton){
        sender.showAnimation {
            let vc = RegisterViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        loginLabel.isHidden = true
        cancelButton.isHidden = true
        self.title = "登录"
        loginManager.delegate = self
        view.addSubview(loadingView)
        cancelButton.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)

        loginButton.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerAction(sender:)), for: .touchUpInside)
        

        view.addSubview(cancelButton)
        view.addSubview(loginLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(12)
            make.left.equalTo(view).offset(20)
        }
        
        loginLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(16)
        }
        
        usernameLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(24)
            make.top.equalTo(loginLabel.snp_bottomMargin).offset(100)
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
        loginButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(30)
            make.right.equalTo(view).offset(-24)
        }
        
        registerButton.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo(view).offset(-50)
        }
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == usernameTextField {
            usernameTextField.placeholder = ""
            passwordTextField.placeholder = "输入密码"
            usernameTextField.addLine(position: .bottom, color: K.brandPink, width: 3.0)
        }else{
            passwordTextField.placeholder = ""
            usernameTextField.placeholder = "输入用户名"
            passwordTextField.addLine(position: .bottom, color: K.brandPink, width: 3.0)
        }

        

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTextField.addLine(position: .bottom, color: .black, width: 3.0)
        }else{
            passwordTextField.addLine(position: .bottom, color: .black, width: 3.0)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}


class LoginTextField: UITextField {
    let padding = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0);

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

extension LoginViewController: LoginDelegate{
    

    func didLoginSucceed(_ loginManager: LoginManager, _ user: LoginModel) {
        DispatchQueue.main.sync {
            if user.userName != nil {
                User.defaults.setValue(user.userName, forKey: "Name")
                User.defaults.synchronize()
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}
    
    

