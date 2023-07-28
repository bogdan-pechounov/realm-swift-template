//
//  ContentView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @StateObject var app = Realm.app
    
    var body: some View {
        MainScreenSync()
            .environmentObject(app)
            .if(app.currentUser) { view, user in
                view.environment(\.realmConfiguration, user.createFlexibleConfiguration())
            }
    }
}

struct MainScreenSync: View{
    @EnvironmentObject var app: RealmSwift.App
    @ObservedResults(Item.self) var syncedItems
    
    var body: some View {
        VStack {
            MainScreen()
            if let user = app.currentUser {
                Text(user.description)
                DeleteAccount()
            }
        }
        .onAppear {
            print("APPEAR")
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


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<Content: View, T>(_ object: T?, transform: (Self, T) -> Content) -> some View {
        if let object = object {
            transform(self, object)
        } else {
            self
        }
    }
}
