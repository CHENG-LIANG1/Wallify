//
//  SubscriptionViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit

class DiscoverViewController: UIViewController {
    var wallData: WallpaperModel?
    var resultImages: [hit] = []
    var keyword = "wall"
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.layer.borderWidth = 0.7
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 10
        tf.borderStyle = .none
        tf.enablesReturnKeyAutomatically = true
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Arial", size: 15)!
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "请输入关键词...", attributes: attributes)
        tf.font = .systemFont(ofSize: 15, weight: .bold)
        tf.setLeftPaddingPoints(10)
        tf.returnKeyType = .search

        return tf
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.backgroundColor = K.brandGreen
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    let trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 5, bottom: 10.0, right: 5)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
        cv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cv.backgroundColor = .white
        return cv
    }()
    
    let trending = ["cosmos", "forest", "4k", "beauty", "cloud", "sky", "animal", "cat", "ocean", "mountain"]
    
    let headingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "热门"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    
    let trendingContentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TrendingContent.self, forCellWithReuseIdentifier: "TrendingContent")
        cv.alwaysBounceVertical = false
        cv.backgroundColor = .white
        return cv
    }()


    
    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
    
    
    @objc func cancel(sender: UIButton){
        sender.showAnimation { [self] in
            searchTextField.text = ""
            searchTextField.endEditing(true)
        }
    }
    
    func getSearchResults(onCompletion:@escaping () -> ()){
        resultImages = []
        let urlString = "https://pixabay.com/api/?key=22378202-2892173d5a410b036771c0f3c&image_type=photo&orientation=vertical&order=latest&per_page=200&q=\(keyword)&safesearch=true".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
 
        URLSession.shared.dataTask(with: URL(string: urlString!)!, completionHandler: { [self]data, response, error in
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


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "发现"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        searchTextField.delegate = self
        view.addSubview(searchTextField)
        view.addSubview(cancelButton)
        view.addSubview(trendingCollectionView)
        view.addSubview(headingLabel)
        view.addSubview(trendingContentCollectionView)
        
        getSearchResults { [self] in

            self.trendingContentCollectionView.reloadData()

        }
        



        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        
        cancelButton.isHidden = true
        
        searchTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        cancelButton.snp.makeConstraints {(make) -> Void in
 
            make.top.equalTo(view).offset(15)
            make.right.equalTo(searchTextField.snp_rightMargin).offset(3)
        }
        
        trendingCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(searchTextField.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        headingLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(trendingCollectionView.snp_bottomMargin).offset(16)
            make.left.equalTo(view).offset(30)
        }
        
        trendingContentCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(headingLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(0)
        }
        
        trendingContentCollectionView.delegate = self
        trendingContentCollectionView.dataSource = self
        
    }
    
}


extension DiscoverViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.layer.borderWidth = 2.5
        searchTextField.layer.borderColor = K.brandPink.cgColor
        cancelButton.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.layer.borderWidth = 0.7
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        cancelButton.isHidden = true
        keyword = searchTextField.text!

        if  keyword != "wall" && searchTextField.text != ""{
            
            getSearchResults { [self] in
                self.headingLabel.text = "Results for '\(searchTextField.text!)'"
                self.trendingContentCollectionView.reloadData()
            }
        }
        

    }
    
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.trendingCollectionView {
            return CGSize(width: K.screenWidth / 6, height: 30)
        }

        return CGSize(width: K.screenWidth / 2.5, height: K.screenWidth / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.trendingCollectionView {
            return trending.count
        }
        return resultImages.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == trendingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
            cell.trengingLabel.text = trending[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingContent", for: indexPath) as! TrendingContent
        cell.cateImage.sd_setImage(with: URL(string: resultImages[indexPath.row].previewURL!), completed: nil)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trendingCollectionView {
            self.headingLabel.text = "Results for '\(trending[indexPath.row])'"
            
            keyword = trending[indexPath.row]
            getSearchResults {
                DispatchQueue.main.async{ [self] in
                    self.trendingContentCollectionView.setContentOffset(.zero, animated: true)
                    self.trendingContentCollectionView.reloadData()
                }
            }
        }else{
            let vc = WallpaperInfoViewController()
            vc.largeImage.sd_setImage(with: URL(string: resultImages[indexPath.row].webformatURL!), completed: nil)
            vc.imageWidth = resultImages[indexPath.row].imageWidth
            vc.imageHeight = resultImages[indexPath.row].imageHeight
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

}

