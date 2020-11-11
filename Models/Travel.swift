//
//  Travel.swift
//  TravelApplication
//
//  Created by User on 8/27/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import Foundation
class Travel {
    var userId: String
    var id: String
    var name: String
    var description: String
    var stops: [Stop] = []
    init (userId: String, id: String, name: String, description: String) {
        self.userId = userId
        self.id = id
        self.name = name
        self.description = description
    }
    var avarageRate: Int {
        guard stops.count > 0 else {return 0}
        var sum = 0
        for stop in stops {
            sum += stop.rating
        }
        return sum/stops.count
    }
    func getAvarageRating() -> Int {
        guard stops.count > 0 else {return 0}
        var sum = 0
        for stop in stops {
            sum += stop.rating
        }
        return sum/stops.count
    }
    
    var json: [String: Any] {
        return ["id": id,
                "name": name,
                "stops": stops.map({$0.json}),
                "description": description]
    }
    
}
