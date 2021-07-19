//
//  WallpaperInfoViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/6.
//

import UIKit
import SCLAlertView
import NVActivityIndicatorView
class WallpaperInfoViewController: UIViewController {

    var imageHeight: Int?
    var imageWidth: Int?
    var height: Int?
    
    var smallImgUrl: String?
    var largeImgUrl: String?

    var largeImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10

        return iv
    }()
    
    let downloadButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setTitle("下载壁纸", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = K.brandGreen
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    
    let favrateButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setTitle("收藏壁纸", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = K.brandRed
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    

    
    @objc func image(_ image: UIImage,
         didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

         if let error = error {
             print("ERROR: \(error)")
         }else {
            let appearence = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            
            
            
            let alertView = SCLAlertView(appearance: appearence)
            alertView.addButton("好的", action: {
                
            })
            
            alertView.showTitle("下载成功", subTitle: "请在相册中查看", style: .success, colorStyle: 0x29BB89)
            
         }
     }
    
    @objc func download(sender: UIButton){
        sender.showAnimation { [self] in
            UIImageWriteToSavedPhotosAlbum(largeImage.image!, self,
                #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func favorite(sender: UIButton){
        sender.showAnimation { [self] in
            
            
            if let favorites = User.defaults.object(forKey: "Favorites") as? NSData {
                User.favs = NSKeyedUnarchiver.unarchiveObject(with: favorites as Data) as! [FavWallpaperModel]
                    }
            
            let appearance = SCLAlertView.SCLAppearance(
                showCircularIcon: true
            )
            let alertView = SCLAlertView(appearance: appearance)
            let config = UIImage.SymbolConfiguration(scale: .medium)
            let alertViewIcon = UIImage(systemName: "suit.heart.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white, renderingMode: .alwaysOriginal)
            
            
            if User.defaults.string(forKey: "Name") == nil {
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let wallPaper = FavWallpaperModel(smallPicUrl: self.smallImgUrl!, largePicUrl: self.largeImgUrl!, width: imageWidth!, height: imageHeight!)
                User.favs.append(wallPaper)

                let favModelsToStore = NSKeyedArchiver.archivedData(withRootObject: User.favs)
                User.defaults.setValue(favModelsToStore, forKey: "Favorites")
                alertView.showTitle("已收藏", subTitle: "请在「我的收藏」中查看", style: .success, colorStyle: 0xED6663, circleIconImage: alertViewIcon)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        

        
        downloadButton.addTarget(self, action: #selector(download(sender:)), for: .touchUpInside)
        favrateButton.addTarget(self, action: #selector(favorite(sender:)), for: .touchUpInside)
        
        height = imageHeight! > imageWidth! ? 600 : 200
        
        largeImage.heightAnchor.constraint(equalToConstant: CGFloat(height!)).isActive = true
        
        
        view.backgroundColor = .white
        view.addSubview(largeImage)
        view.addSubview(downloadButton)
        view.addSubview(favrateButton)

        
        largeImage.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        downloadButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(largeImage.snp_bottomMargin).offset(32)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        favrateButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(downloadButton.snp_bottomMargin).offset(24)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        

    }
    
}
