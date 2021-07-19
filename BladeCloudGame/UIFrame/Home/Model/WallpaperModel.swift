//
//  WallData.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/6.
//

import UIKit

struct WallpaperModel: Codable {
    var hits: [hit]?
}

struct hit: Codable {
    var id: Int?
    var largeImageURL: String?
    var previewURL: String?
    var webformatURL: String?
    var imageHeight: Int?
    var imageWidth: Int?
}
