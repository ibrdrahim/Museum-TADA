//
//  UserViewModel.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

enum UserValidationState{
    case Valid
    case Invalid(String)
}

class UserViewModel{
    private let minUsernameLength = 4
    private let minPasswordLength = 6
    private var user = User()
    
    var username: String{
        return user.username
    }
    
    var password: String{
        return user.password
    }
}

extension UserViewModel{
    func updateUsername(username: String){
        user.username = username
    }
    
    func updatePassword(password: String){
        user.password = password
    }
    
    func validate() -> UserValidationState{
        if user.username.isEmpty || user.password.isEmpty{
            return .Invalid("Username and password are required.")
        }
        
        if user.username.count < minUsernameLength{
            return .Invalid("Username needs to be at least \(minUsernameLength) characters long.")
        }
        
        if user.password.count < minPasswordLength{
            return .Invalid("Password needs to be at least \(minPasswordLength) characters long.")
        }
        
        return .Valid
        
    }
    
    func login(completion: @escaping (_ msg: String?) -> Void){
        let provider = MoyaProvider<AuthApi>()
        LoadingOverlay.shared.showOverlay()
        provider.request(.login(email: user.username, password: user.password)) { (result) in
            switch result{
            case let .success(response):
                LoadingOverlay.shared.hideOverlay()
                do{
                    let responseJSON:Any = try response.mapJSON()
                    let responseObject:AuthResponse = Mapper<AuthResponse>().map(JSONObject: responseJSON)!
                    if responseObject.error == nil || responseObject.error == "" {
                        let userData = UserLoginProvider.getLoginData()
                
                        userData.updateUsername(self.user.username)
                        userData.updateToken(responseObject.token!)
                        
                        completion(nil)
                    }else{
                        completion(responseObject.error)
                    }
                    
                }catch{
                    completion("Server returned invalid message")
                }
            case .failure(_):
                LoadingOverlay.shared.hideOverlay()
                completion("Server failed to response")
            }
        }
    }
    
    func register(completion: @escaping (_ msg: String?) -> Void){
        let provider = MoyaProvider<AuthApi>()
        LoadingOverlay.shared.showOverlay()
        provider.request(.register(email: user.username, password: user.password)) { (result) in
            switch result{
            case let .success(response):
                LoadingOverlay.shared.hideOverlay()
                do{
                    let responseJSON:Any = try response.mapJSON()
                    let responseObject:AuthResponse = Mapper<AuthResponse>().map(JSONObject: responseJSON)!
                    if responseObject.error == nil || responseObject.error == "" {
                        let userData = UserLoginProvider.getLoginData()
                        
                        userData.updateUsername(self.user.username)
                        userData.updateToken(responseObject.token!)
                        
                        completion(nil)
                    }else{
                        completion(responseObject.error)
                    }
                    
                }catch{
                    completion("Server returned invalid message")
                }
            case .failure(_):
                LoadingOverlay.shared.hideOverlay()
                completion("Server failed to response")
            }
        }
    }
}
