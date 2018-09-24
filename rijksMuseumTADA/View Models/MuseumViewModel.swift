//
//  MuseumViewModel.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import UIKit

class MuseumViewModel {
    
    typealias MuseumCollectionViewCellData = (imageUrl: String, headerUrl: String, title: String, longTitle: String)
    let museumsObservable = BehaviorSubject<[MuseumCollectionViewCellData]>(value: [])
    let museumApiClient = MuseumApiClient()
    let disposeBag = DisposeBag()
    
    var museums: [MuseumCollectionViewCellData] = []
    
    var startIndexProducts = 0
    
    private static var _instance: MuseumViewModel? = nil
    static var sharedInstance: MuseumViewModel {
        if _instance == nil {
            _instance = MuseumViewModel()
        }
        
        return _instance!
    }
    
    private init() {
        refreshInitialMuseumData()
    }
    
    func refreshInitialMuseumData(page: Int = 0, per_page: Int = 10) {
        self.startIndexProducts = 0
        self.museums.removeAll()
        
        var req = MuseumRequest()
        req.p = page
        req.ps = per_page
        
        museumApiClient.getProducts(req: req)
            .subscribe(
                onNext: { [unowned self] res in
                    let formattedView = res.data.map {
                        return (
                            imageUrl: $0.webImage!,
                            headerUrl: $0.headerImage!,
                            title: $0.title!,
                            longTitle: $0.longTitle!
                        )
                        
                    }
                    self.museums = formattedView
                    self.museumsObservable.onNext(formattedView)
                }, onError: { err in
                    self.museumsObservable.onNext([])
            })
            .disposed(by: disposeBag)
    }
    
    func refreshMuseumDataInfinity(page: Int = 0, per_page: Int = 10) {
        
        startIndexProducts += 10
        
        var req = MuseumRequest()
        req.p = startIndexProducts
        req.ps = per_page
        
        museumApiClient.getProducts(req: req)
            .subscribe(
                onNext: { [unowned self] res in
                let formattedView = res.data.map {
                    return (
                        imageUrl: $0.webImage!,
                        headerUrl: $0.headerImage!,
                        title: $0.title!,
                        longTitle: $0.longTitle!
                    )
                }
                
                self.museums.append(contentsOf: formattedView)
                self.museumsObservable.onNext(self.museums)
                }, onError: { err in
                    self.museumsObservable.onNext([])
            })
            .disposed(by: disposeBag)
    }
}
