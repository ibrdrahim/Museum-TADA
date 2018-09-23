//
//  GenericModel.swift
//  rijksMuseumTADA
//
//  Created by Muhammad Yaqub on 23/09/18.
//  Copyright © 2018 Muhammad Yaqub. All rights reserved.
//

import Foundation
import RealmSwift

class GenericModel: Object{
    func insert(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    func upsert(){
        let realm = try! Realm()
        try! realm.write {
            realm.add(self,update:true)
        }
    }
    func delete(){
        let realm = try! Realm()
        realm.delete(self)
    }
    
    static func insert(data:[GenericModel]){
        let realm = try! Realm()
        try! realm.write {
            realm.add(data)
        }
    }
    static func get<T : Object>(type : T.Type) -> Results<T> {
        let realm = try! Realm()
        let localData =  realm.objects(T.self)
        return localData
    }
    
    static func delete<T : GenericModel>(type : T.Type) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(GenericModel.get(type: type))
        }
    }
}
