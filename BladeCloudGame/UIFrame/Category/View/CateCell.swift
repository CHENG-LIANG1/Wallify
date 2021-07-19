//
//  CateCell.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/6.
//

import UIKit

class CateCell: UICollectionViewCell {

    
    let cateImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let cateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 22, weight: .bold)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(cateImage)
        contentView.addSubview(cateLabel)
        
        cateImage.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(0)
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
        }
        
        cateLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(-8)
            
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
