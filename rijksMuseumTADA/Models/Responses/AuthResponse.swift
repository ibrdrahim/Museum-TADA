//
//  AuthResponse.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import ObjectMapper

class AuthResponse : Mappable {
    var token : String?
    var error : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        error <- map["error"]
    }
}
