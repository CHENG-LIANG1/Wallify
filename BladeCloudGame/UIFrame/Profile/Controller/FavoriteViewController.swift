//
//  FavoriteViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import UIKit


class FavoriteViewController: UIViewController {
    let favCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 24.0, bottom: 10.0, right: 24.0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CateSmallCell.self, forCellWithReuseIdentifier: "CateSmallCell")

        cv.backgroundColor = .white
        return cv
    }()
    
    var favArray = [FavWallpaperModel]()
    
    let instructionLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 10
        lbl.clipsToBounds = true
        lbl.text = "暂无收藏"
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        return lbl
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收藏"
        if let favorites = User.defaults.object(forKey: "Favorites") as? NSData {
            favArray = NSKeyedUnarchiver.unarchiveObject(with: favorites as Data) as! [FavWallpaperModel]
        }
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false

        Tools.setHeight(instructionLabel, 50)
        
        view.addSubview(favCollectionView)
        view.addSubview(instructionLabel)

        instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        favCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
        
        instructionLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(150)
        }

        
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
    }
}



extension FavoriteViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.screenWidth / 5, height: K.screenWidth / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favArray.count > 0 {
            instructionLabel.isHidden = true
        }else{
            instructionLabel.isHidden = false
        }
        
        return favArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateSmallCell", for: indexPath) as! CateSmallCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.cateImage.sd_setImage(with: URL(string: favArray[indexPath.row].smallPicUrl!), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WallpaperInfoViewController()
        vc.largeImage.sd_setImage(with: URL(string: favArray[indexPath.row].largePicUrl!), completed: nil)
        vc.imageWidth = favArray[indexPath.row].width
        vc.imageHeight = favArray[indexPath.row].height
        vc.largeImgUrl = favArray[indexPath.row].largePicUrl
        vc.smallImgUrl = favArray[indexPath.row].smallPicUrl
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
