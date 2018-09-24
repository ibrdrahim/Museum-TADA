//
//  AuthApiEndpoint.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import Moya

enum AuthApi{
    case login(email: String, password: String)
    case register(email: String, password: String)
}

extension AuthApi: TargetType{
    var baseURL: URL {
        return URL(string: "https://reqres.in/api/")!
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "login"
        case .register(_):
            return "register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_), .register(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password), .register(let email, let password):
            return .requestParameters(parameters: ["email": email, "password" : password], encoding: URLEncoding.httpBody)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Content-type": "application/x-www-form-urlencoded"]
    }
    
}
