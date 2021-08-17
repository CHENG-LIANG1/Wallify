//
//  K.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/6/29.
//

import UIKit

struct K {
    static let KeyWord = ""
    static let API = "https://api.nasa.gov/planetary/\(KeyWord)?api_key=thknETxlD938bg9F4udEBwNBMwTSdt2pr3VdcglV"
    static let API2 = "https://otappdataapi.moguyouxi.cn:8600/AppApi/api/"
    static let Suffix = "sj_debug_=true&BossId=\(BossId)&Version=\(Version)&AppId=\(AppId)"
    static let BossId = 25006
    static let AppId = "4"
    static let Version = "1.0.0"
    
    static let brandYellow = #colorLiteral(red: 0.968627451, green: 0.9921568627, blue: 0.01568627451, alpha: 1)
    static let brandLight = #colorLiteral(red: 0.9725490196, green: 0.9607843137, blue: 0.9450980392, alpha: 1)
    static let brandPink = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5098039216, alpha: 1)
    static let brandLightPink = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.9960784314, alpha: 1)
    static let brandPurple = #colorLiteral(red: 0.5176470588, green: 0.368627451, blue: 0.7607843137, alpha: 1)
    static let brandRed = #colorLiteral(red: 0.9294117647, green: 0.4, blue: 0.3882352941, alpha: 1)
    static let brandBlue = #colorLiteral(red: 0.1568627451, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
    static let brandGreen = #colorLiteral(red: 0.1607843137, green: 0.7333333333, blue: 0.537254902, alpha: 1)
    static let brandLightGreen = #colorLiteral(red: 0.431372549, green: 0.9529411765, blue: 0.8392156863, alpha: 1)
    static let brandDark = #colorLiteral(red: 0.1647058824, green: 0.2117647059, blue: 0.231372549, alpha: 1)
    static let brandLightGray = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}
