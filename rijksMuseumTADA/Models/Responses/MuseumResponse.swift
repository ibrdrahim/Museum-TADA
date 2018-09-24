//
//  MuseumResponse.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import ObjectMapper

class MuseumResponse: Mappable {
    var data: [MuseumData]! = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["artObjects"]
    }
    
    class MuseumData: Mappable {
        var id: Int!
        var title: String!
        var longTitle: String!
        var headerImage: String!
        var webImage: String!
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            id <- map["id"]
            title <- map["title"]
            longTitle <- map["longTitle"]
            headerImage <- map["headerImage.url"]
            webImage <- map["webImage.url"]
        }
    }
    
}
