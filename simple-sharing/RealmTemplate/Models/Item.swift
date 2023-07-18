//
//  Item.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import RealmSwift

class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var userId: String
    @Persisted var name: String
    
    convenience init(name: String, userId: String? = nil) {
        self.init()
        self.name = name
        if let userId = userId {
            self.userId = userId
        }
    }
}


