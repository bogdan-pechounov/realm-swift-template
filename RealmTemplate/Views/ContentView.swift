//
//  ContentView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var app = Realm.app
    
    var body: some View {
        if let config = app.createFlexibleConfiguration() {
            MainScreenSync()
                .environment(\.realmConfiguration, config)
                .environmentObject(app)
        } else {
            MainScreen()
                .environmentObject(app)
        }
    }
}

struct MainScreenSync: View{
    @EnvironmentObject var app: RealmSwift.App
    //    @Environment(\.realm) var syncedRealm
    @ObservedResults(Item.self) var syncedItems
    
    var body: some View {
        VStack {
            MainScreen()
            Text(app.currentUser?.description ?? "not logged in")
        }
        .onAppear {
            if let localRealm = try? Realm(), let user = app.currentUser {
                let localItems = localRealm.objects(Item.self)
                for item in localItems {
                    // local -> synced
                    let syncedItem = Item(value: item)
                    syncedItem.userId = user.id
                    $syncedItems.append(syncedItem)
                    // delete local
                    try? localRealm.write {
                        localRealm.delete(item)
                    }
                }
            }
        }
    }
}
