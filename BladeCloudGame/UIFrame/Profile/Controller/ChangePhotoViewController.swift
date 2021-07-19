//
//  ChangePhotoViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import UIKit

class ChangePhotoViewController: UIViewController, ImagePickerDelegate {

    let profilePicture: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: K.screenWidth - 16).isActive = true
        iv.heightAnchor.constraint(equalToConstant: K.screenWidth - 16).isActive = true
        return iv
    }()
    
    //ser.profilePics = User.defaults.imageArray(forKey: "images")
    
    let selectButton = Tools.setUpButton("选择照片", K.brandGreen, 18)
    
    @objc func selectAction(sender: UIButton){
        sender.showAnimation {
            self.imgPicker?.present(from: sender)
        }
    }
    
    var imgPicker: ImagePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "更新头像"
        
        selectButton.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        
        view.backgroundColor = .white
        view.addSubview(profilePicture)
        view.addSubview(selectButton)
        
        if User.profilePics.count > 0 {
            profilePicture.image = User.profilePics[User.profilePics.count - 1]
        }else{
            profilePicture.image = UIImage(named: "GamePic2")
        }

        selectButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        self.imgPicker = ImagePicker(presentationController: self, delegate: self)

        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profilePicture.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(150)
        }
        
        selectButton.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo(view).offset(-50)
        }

    }
    
    func didSelect(image: UIImage?) {
        User.profilePics.append(image!)
        User.defaults.set(User.profilePics, forKey: "images")
        profilePicture.image = image
    }
}
