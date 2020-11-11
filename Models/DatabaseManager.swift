//
//  DatabaseManager.swift
//  TravelApplication
//
//  Created by mnem on 11/2/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    var array = ["a","b","c"]
    
    func saveTravelInDatabase(_ travel: Travel) {
        let rlmTravel = RLMTravel()
        rlmTravel.name = travel.name
        rlmTravel.desc = travel.description
        rlmTravel.id = travel.id
        rlmTravel.userId = travel.userId
        for stop in travel.stops {
            let rlmStop = RLMStop()
            rlmStop.id = stop.id
            rlmStop.travelId = stop.travelId
            rlmStop.name = stop.name
            rlmStop.rating = stop.rating
            rlmStop.currency = stop.currency
            rlmStop.spentMoney = stop.spentMoney
            rlmStop.latitude = Double(stop.location.x)
            rlmStop.longitude = Double(stop.location.y)
            rlmStop.desc = stop.description
            rlmStop.transport = stop.transport
            rlmTravel.stops.append(rlmStop)
        }
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(rlmTravel, update: .all)
        }
//        realm.beginWrite()
//        realm.add(rlmTravel)
//        try! realm.commitWrite()
        
    }
    func clear() {
        let realm = try! Realm()
        
        let rlmTravels = realm.objects(RLMTravel.self)
//        let rlmStop
    }
    func getObjects<T: Object>(classType: T.Type) -> [T] {
        var result: [T] = []
        let realm = try! Realm()
        let objects = realm.objects(T.self)
        for object in objects {
            result.append(object)
        }
        return result
    }
}


