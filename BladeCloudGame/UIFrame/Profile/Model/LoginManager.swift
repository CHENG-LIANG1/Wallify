//
//  LoginManager.swift
//  BladeCloudGame
//
//  Created by 梁程 on 2021/7/12.
//

import Foundation

protocol LoginDelegate {
    func didLoginSucceed(_ loginManager: LoginManager, _ user: LoginModel)
}


struct LoginManager {
    var delegate: LoginDelegate?
    func getUserData(_ userNameString: String, _ passwordString: String){

        let urlString = "\(K.API2)Account/UserLogin.ashx?\(K.Suffix)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "\(urlString)&LoginAccount=\(userNameString)&Password=\(passwordString)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {print("Something went wrong")}
            if let data = data{
                var result: WallpaperData?
                var loginModel = LoginModel()
                do{
                    result = try JSONDecoder().decode(WallpaperData.self, from: data)
                }catch{
                    print(error)
                }
                if result?.Code! == 0 {
                    CBToast.showToastAction(message: "登录成功！")
                    let loginData = result?.Data?.data(using: String.Encoding.utf8)
                    let loginJSON = try! JSONSerialization.jsonObject(with: loginData!, options: .mutableContainers) as? NSMutableDictionary
                    loginModel.userName = loginJSON!["LoginAccount"] as? String

                    self.delegate?.didLoginSucceed(self, loginModel)
                    

                    
                    
                }else {
                    CBToast.showToastAction(message: (result?.Description)! as NSString)
                    return
                }
            }
        }
        task.resume()

    }
}
