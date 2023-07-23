//
//  Item.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import RealmSwift

class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var userId: String?
    
    @Persisted var name: String
    @Persisted(indexed: true) var order: Int
    
    convenience init(name: String, order: Int, userId: String? = nil) {
        self.init()
        self.userId = userId

        self.name = name
        self.order = order
    }
}


