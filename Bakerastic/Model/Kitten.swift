//
//  Kitten.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Kitten: Object, Mappable {
    dynamic var id = NSUUID().uuidString
    dynamic var imageUrl = ""
    dynamic var info: Info?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        imageUrl <- map["imageURL"]
        info <- map["info"]
    }
}
