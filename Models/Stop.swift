//
//  Stop.swift
//  TravelApplication
//
//  Created by User on 8/27/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import RealmSwift

enum Transport: Int, RealmEnum {
    case none, car, airplan, train
}

class Stop {
    var id: String
    var travelId: String
    var name: String = ""
    var rating: Int = 0
    var location: CGPoint = .zero //CGPoint(x:0,y:0)
    var spentMoney: Double = 0
    var transport: Transport = .none
    var description: String = ""
    var currency: Currency = .none
    
    init(id:String, travelId:String) {
        self.id = id
        self.travelId = travelId
    }
    
    var json: [String: Any] {
        return ["id": id,
                "travelId": travelId,
                "name": name,
                "rating": rating,
                "location": "\(location.x)-\(location.y)",
                "transport": transport.rawValue,
                "description": description,
                "spentMoney": spentMoney,
                "currency": currency.rawValue]
    }
    
}
