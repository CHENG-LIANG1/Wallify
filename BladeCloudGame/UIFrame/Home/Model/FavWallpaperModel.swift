//
//  WallPaperModel.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import UIKit
class FavWallpaperModel: NSObject, NSCoding {
    var smallPicUrl: String?
    var largePicUrl: String?
    var width: Int?
    var height: Int?


    init(smallPicUrl: String, largePicUrl: String, width: Int, height: Int) {
        self.smallPicUrl = smallPicUrl
        self.largePicUrl = largePicUrl
        self.width = width
        self.height = height

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(smallPicUrl, forKey: "small")
        coder.encode(largePicUrl, forKey: "large")
        coder.encode(width, forKey: "width")
        coder.encode(height, forKey: "height")

    }
    
    required init?(coder decoder: NSCoder) {
        self.smallPicUrl = decoder.decodeObject(forKey: "small") as? String
        self.largePicUrl = decoder.decodeObject(forKey: "large") as? String
        self.width = decoder.decodeObject(forKey: "width") as? Int
        self.height = decoder.decodeObject(forKey: "height") as? Int

    }
}
