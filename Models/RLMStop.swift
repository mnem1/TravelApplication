//
//  RLMStop.swift
//  TravelApplication
//
//  Created by mnem on 11/2/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import Foundation
import RealmSwift

class RLMStop: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var travelId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var rating: Int = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude:Double = 0
    @objc dynamic var spentMoney: Double = 0
    dynamic var transport: Transport = .none
    @objc dynamic var desc: String = ""
    dynamic var currency: Currency = .none
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMStop.id)
    }
    
}
