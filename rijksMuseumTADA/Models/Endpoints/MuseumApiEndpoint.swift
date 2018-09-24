//
//  MuseumApiEndpoint.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import Moya

enum MuseumApi{
    case collection(request: MuseumRequest)
}

extension MuseumApi: TargetType{
    var baseURL: URL {
        return URL(string: "https://www.rijksmuseum.nl/api/en/")!
    }
    
    var path: String {
        switch self {
        case .collection(_):
            return "collection/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .collection(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .collection(let request):
            let api_key = "N1r8D73d"
            return .requestParameters(parameters: ["imgonly" : true, "key" : api_key, "p": request.p, "ps" : request.ps], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
