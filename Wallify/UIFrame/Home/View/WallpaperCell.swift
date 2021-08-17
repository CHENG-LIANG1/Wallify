//
//  GameTableViewCell.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/2.
//

import UIKit
import NVActivityIndicatorView

class WallpaperCell: UITableViewCell {


    let loadingView = NVActivityIndicatorView(frame: .zero, type: .lineScale, color: K.brandPink, padding: 1.0)
    
    var featuredWallpaper: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(featuredWallpaper)
        contentView.addSubview(loadingView)
        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        featuredWallpaper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        featuredWallpaper.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        featuredWallpaper.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        featuredWallpaper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        loadingView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(contentView).offset(100)
            make.top.equalTo(contentView).offset(50)

        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

