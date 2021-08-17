//
//  HomeViewController.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    var gameData: WallpaperData?

    var bannerData: [BannerData] = []

    var imageView: UIImageView?
    var wallData: WallpaperModel?
    var resultImages: [hit] = []
    var featuredImages: [hit] = []
    
    
    let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        cv.heightAnchor.constraint(equalToConstant: K.screenHeight / 4.8).isActive = true
        cv.widthAnchor.constraint(equalToConstant: K.screenWidth).isActive = true
        cv.backgroundColor = .white
        return cv
    }()
    
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: UIScreen.main.bounds)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    

    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "热门壁纸"
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()
    
    let gameTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.widthAnchor.constraint(equalToConstant: K.screenWidth - 40).isActive = true
        tv.isScrollEnabled = false
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
           

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.title = "主页"
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        gameTableView.register(WallpaperCell.self, forCellReuseIdentifier: "WallCell")
        
        let loadingView = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 9.6, width: 100, height: 50), type: .lineScale, color: K.brandPink, padding: 1.0)
        
        let loadingView2 = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 2, width: 100, height: 50), type: .lineScale, color: K.brandPink, padding: 1.0)

        
      
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.isPagingEnabled = true
        gameTableView.delegate = self
        gameTableView.dataSource = self
        
        gameTableView.rowHeight = 200
        

        scrollView.showsVerticalScrollIndicator = false
        loadingView.startAnimating()
        
        getBannerImages { [self] in
    
            self.bannerCollectionView.reloadData()
            loadingView.stopAnimating()
        }
        
        loadingView2.startAnimating()
        getFeaturedImages { [self] in
            
            gameTableView.heightAnchor.constraint(equalToConstant: gameTableView.rowHeight * CGFloat(featuredImages.count)).isActive = true
            scrollView.contentSize = CGSize(width: K.screenWidth, height: K.screenHeight / 4.8 + gameTableView.rowHeight * CGFloat(featuredImages.count))
            self.gameTableView.reloadData()
            loadingView2.stopAnimating()

        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(bannerCollectionView)
        scrollView.addSubview(headerLabel)
        scrollView.addSubview(gameTableView)
        scrollView.addSubview(loadingView)
        scrollView.addSubview(loadingView2)


        scrollView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
        
        headerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bannerCollectionView.snp_bottomMargin).offset(16)
            make.left.equalTo(scrollView).offset(30)
        }
        
        gameTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headerLabel.snp_bottom).offset(0)
            make.left.equalTo(view).offset(20)
        }
     
    }

 
    func getBannerImages(onCompletion:@escaping () -> ()){
        let urlString = "https://pixabay.com/api/?key=22378202-2892173d5a410b036771c0f3c&q=sky&image_type=photo&order=latest&orientation=horizontal"
        
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
    
    func getFeaturedImages(onCompletion:@escaping () -> ()){
        let urlString = "https://pixabay.com/api/?key=22378202-2892173d5a410b036771c0f3c&image_type=photo&orientation=horizontal"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { [self]data, response, error in
            if error == nil {
                do{
                    self.wallData = try JSONDecoder().decode(WallpaperModel.self, from: data!)
                    
                    for img in wallData!.hits! {
                        self.featuredImages.append(img)
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
}




extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.bg.sd_setImage(with: URL(string: resultImages[indexPath.row].webformatURL!), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WallpaperInfoViewController()
        vc.largeImage.sd_setImage(with: URL(string: resultImages[indexPath.row].webformatURL!), completed: nil)
        vc.largeImgUrl = resultImages[indexPath.row].largeImageURL
        vc.smallImgUrl = resultImages[indexPath.row].previewURL
        vc.imageWidth = resultImages[indexPath.row].imageWidth
        vc.imageHeight = resultImages[indexPath.row].imageHeight
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WallCell", for: indexPath) as! WallpaperCell
        
        cell.featuredWallpaper.sd_setImage(with: URL(string: featuredImages[indexPath.row].webformatURL!), completed: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WallpaperInfoViewController()
        vc.largeImage.sd_setImage(with: URL(string: featuredImages[indexPath.row].webformatURL!), completed: nil)
        vc.imageWidth = featuredImages[indexPath.row].imageWidth
        vc.imageHeight = featuredImages[indexPath.row].imageHeight
        vc.largeImgUrl = featuredImages[indexPath.row].largeImageURL
        vc.smallImgUrl = featuredImages[indexPath.row].previewURL
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

}
