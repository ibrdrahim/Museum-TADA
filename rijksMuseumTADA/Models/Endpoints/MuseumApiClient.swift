//
//  MuseumApiClient.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper

struct MuseumApiClient {
    
    private let provider = MoyaProvider<MuseumApi>()
    
    // request products data, and return response as observable
    func getProducts(req: MuseumRequest) -> Observable<MuseumResponse> {
        return provider.rx
            .request(.collection(request: req))
            .mapObject(MuseumResponse.self)
            .retry(3)
            .asObservable()
    }
    
}
