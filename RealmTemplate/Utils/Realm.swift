//
//  Realm.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import Foundation
import RealmSwift

extension Realm {
    static let app = RealmSwift.App(id: Config.APP_ID)
}

extension App {
    func createFlexibleConfiguration() -> Realm.Configuration? {
        if let user = self.currentUser {
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                if subs.first(named: "user_items")  == nil {
                    subs.append(QuerySubscription<Item>(name: "user_items") {
                        $0.userId == user.id
                    })
                }
            })
            return config
        }
        return nil
    }
}


