//
//  User.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import RealmSwift

class User: GenericModel {
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var token = ""
    
    func updateUsername(_ username : String){
        let realm = try! Realm()
        try! realm.write {
            self.username = username
        }
    }
    
    func updateToken(_ token : String){
        let realm = try! Realm()
        try! realm.write {
            self.token = token
        }
    }
}
