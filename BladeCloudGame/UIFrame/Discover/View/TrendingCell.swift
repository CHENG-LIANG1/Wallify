//
//  TrendingCell.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/7.
//


import UIKit

class TrendingCell: UICollectionViewCell {

    
    override var isSelected: Bool {
       didSet{
           if self.isSelected {
               UIView.animate(withDuration: 0.3) { // for animation effect
                self.trengingLabel.backgroundColor = K.brandRed
               }
           }
           else {
               UIView.animate(withDuration: 0.3) { // for animation effect
                self.trengingLabel.backgroundColor = K.brandLightPink
               }
           }
       }
   }
    let trengingLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = K.brandDark
        lbl.layer.cornerRadius = 12
        lbl.clipsToBounds = true
        lbl.backgroundColor = K.brandLightPink
        lbl.font = .systemFont(ofSize: 13, weight: .regular)

        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(trengingLabel)
        

        trengingLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(contentView).offset(0)
            make.right.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(0)
            make.top.equalTo(contentView).offset(0)
            
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
