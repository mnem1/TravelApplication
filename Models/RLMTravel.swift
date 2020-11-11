//
//  RLMTravel.swift
//  TravelApplication
//
//  Created by mnem on 11/2/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import Foundation
import RealmSwift

class RLMTravel: Object {
    @objc dynamic var userId: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    let stops = List<RLMStop>()
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMTravel.id)
        }
    
}

