//
//  SharedWithMe.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-18.
//

import RealmSwift

class SharedWithMe: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var userId: String
    @Persisted var item: Item
}
