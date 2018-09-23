//
//  UserProvider.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation

class UserLoginProvider {
    
    static func initialize(){
        //create login data
        GenericModel.delete(type: User.self)
        let userModel : User = User()
        userModel.insert()
    }
    
    static func getLoginData() -> User{
        guard let loginData =  GenericModel.get(type: User.self).first else {
            let newLoginData = User()
            newLoginData.insert()
            return newLoginData
        }
        return loginData
    }
    
    static func removeLoginData(){
        GenericModel.delete(type: User.self)
    }
    
    static func setLoginData(loginData: User){
        GenericModel.delete(type: User.self)
        GenericModel.insert(data: [loginData])
    }
    
}
