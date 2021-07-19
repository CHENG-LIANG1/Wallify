//
//  BannerCell.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/30.
//

import UIKit
import NVActivityIndicatorView

class BannerCell: UICollectionViewCell {




    var bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true

        iv.layer.cornerRadius = 10
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
