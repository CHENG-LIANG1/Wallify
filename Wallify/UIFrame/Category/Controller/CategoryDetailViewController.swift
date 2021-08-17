//
//  CategoryDetailViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/7.
//

import UIKit
import NVActivityIndicatorView


let cateCollectionView: UICollectionView = {
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

let pickerController = UIImagePickerController()



class CategoryDetailViewController: UIViewController {
    var category: String?
    var wallData: WallpaperModel?
    var resultImages: [hit] = []
    
    func getImagesInSelectedCategory(onCompletion:@escaping () -> ()){
        let urlString = "https://pixabay.com/api/?key=22378202-2892173d5a410b036771c0f3c&image_type=photo&category=\(category!)&orientation=vertical&order=latest&per_page=200&safesearch=true"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.wallData = try JSONDecoder().decode(WallpaperModel.self, from: data!)
                    
                    for img in wallData!.hits! {
                        self.resultImages.append(img)
                    }

                    DispatchQueue.main.async {
                        onCompletion()
                    }
                }catch{
                    print(error)
                }
            }
        }).resume()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(cateCollectionView)

        
        cateCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
        
        cateCollectionView.delegate = self
        cateCollectionView.dataSource = self
        
        getImagesInSelectedCategory {

            cateCollectionView.reloadData()
        }
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.screenWidth / 5, height: K.screenWidth / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateSmallCell", for: indexPath) as! CateSmallCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.cateImage.sd_setImage(with: URL(string: resultImages[indexPath.row].previewURL!), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WallpaperInfoViewController()
        vc.largeImage.sd_setImage(with: URL(string: resultImages[indexPath.row].webformatURL!), completed: nil)
        vc.imageWidth = resultImages[indexPath.row].imageWidth
        vc.imageHeight = resultImages[indexPath.row].imageHeight
        vc.largeImgUrl = resultImages[indexPath.row].largeImageURL
        vc.smallImgUrl = resultImages[indexPath.row].previewURL
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
