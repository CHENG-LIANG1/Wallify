//
//  CategoryViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit

class CategoryViewController: UIViewController {

    var categories = ["fashion", "nature", "science", "education", "feelings", "health", "people", "religion", "places", "animals", "industry", "computer", "food", "sports", "transportation", "travel", "buildings", "business", "music"]
    
    let cateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 24.0, bottom: 10.0, right: 24.0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CateCell.self, forCellWithReuseIdentifier: "CateCell")

        cv.backgroundColor = .white
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "分类"
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
    }
    


}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: K.screenWidth / 2 - 36, height: K.screenWidth / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateCell", for: indexPath) as! CateCell
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 10
        cell.cateLabel.text = categories[indexPath.row].capitalizingFirstLetter()
        cell.cateImage.image = UIImage(named: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryDetailViewController()
        vc.category = categories[indexPath.row]
        vc.title = categories[indexPath.row].capitalizingFirstLetter()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
