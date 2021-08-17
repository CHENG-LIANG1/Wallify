//
//  CateSmallCell.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/7.
//

import UIKit

class CateSmallCell: UICollectionViewCell {

    
    var cateImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(cateImage)

        
        cateImage.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(0)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
        }
        


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
