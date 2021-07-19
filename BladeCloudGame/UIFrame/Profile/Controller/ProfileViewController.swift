//
//  ProfileViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = K.brandLightPink
        view.layer.cornerRadius = 12
        view.addShadow()
        view.heightAnchor.constraint(equalToConstant: K.screenHeight / 5).isActive = true
        return view
    }()
    
    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.image = UIImage(named: "GamePic2")
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: K.screenHeight / 5 - 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: K.screenHeight / 5 - 100).isActive = true
        return iv
    }()
    
    let profileLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "未登录"
        return lbl
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = K.brandPurple
        button.setTitle("登录", for: .normal)
        return button
    }()
    
    let favButton = Tools.setUpProfileButton("我的收藏")
    let accountManageButton = Tools.setUpProfileButton("个人信息")
    let settingsButton = Tools.setUpProfileButton("设置")
    
    @objc func favAction(sender: UIButton){
        sender.showAnimation {
            if User.defaults.string(forKey: "Name") == nil {
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = FavoriteViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func accountAction(sender: UIButton){
        sender.showAnimation {
            if User.defaults.string(forKey: "Name") == nil {
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let vc = AccountViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func settingsAction(sender: UIButton){
        sender.showAnimation {
            if User.defaults.string(forKey: "Name") == nil {
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = SettingsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @objc func loginAction(sender: UIButton){
        sender.showAnimation {
            if User.defaults.string(forKey: "Name") == nil {
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        User.defaults.synchronize()
        self.view.setNeedsLayout()
        
        profileLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        favButton.backgroundColor = K.brandRed
        settingsButton.backgroundColor = .gray
        
        
        if User.defaults.imageArray(forKey: "images") != nil {
            User.profilePics = User.defaults.imageArray(forKey: "images")!
        }
           
    
        if User.defaults.string(forKey: "Name") == nil {
            profileLabel.text = "未登录"
            profileLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            loginButton.isHidden = false
            profileImage.image = UIImage(named: "GamePic2")

        }else {
            profileLabel.text = User.defaults.string(forKey: "Name")
            profileLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            loginButton.isHidden = true
            if User.profilePics.count > 0 {
                profileImage.image = User.profilePics[User.profilePics.count - 1]
            }
            
        }
        
        
        self.title = "我的"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        view.addSubview(profileView)
        profileView.addSubview(profileImage)
        profileView.addSubview(profileLabel)
        profileView.addSubview(loginButton)
        profileView.addSubview(favButton)
        profileView.addSubview(accountManageButton)
        profileView.addSubview(settingsButton)
        


        accountManageButton.addTarget(self, action: #selector(accountAction(sender:)), for: .touchUpInside)
        favButton.addTarget(self, action: #selector(favAction(sender:)), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsAction(sender:)), for: .touchUpInside)
        
        
        profileView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(8)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        profileImage.snp_makeConstraints {(make) -> Void in
            make.left.equalTo(profileView).offset(16)
            make.top.equalTo(profileView).offset(16)
        }
        
        profileLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(profileImage.snp_rightMargin).offset(16)
            make.top.equalTo(profileView).offset(16)
        }
        
        loginButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(profileLabel.snp_bottomMargin).offset(16)
            make.left.equalTo(profileImage.snp_rightMargin).offset(16)
            make.bottom.equalTo(profileImage).offset(0)
            make.right.equalTo(profileView).offset(-16)
        }
        
        favButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(profileImage.snp_bottomMargin).offset(24)
            make.left.equalTo(profileView).offset(16)
            make.bottom.equalTo(profileView).offset(-16)
        }
        accountManageButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(profileImage.snp_bottomMargin).offset(24)
            make.left.equalTo(favButton.snp_rightMargin).offset(24)
            make.bottom.equalTo(profileView).offset(-16)
        }
        settingsButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(profileImage.snp_bottomMargin).offset(24)
            make.left.equalTo(accountManageButton.snp_rightMargin).offset(24)
            make.bottom.equalTo(profileView).offset(-16)
        }


    }
    

}
