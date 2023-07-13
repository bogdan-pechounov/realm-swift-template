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
            MainScreenDebug()
                .environment(\.realmConfiguration, config)
                .environmentObject(app)
        } else {
            MainScreen()
                .environmentObject(app)
        }
    }
}

struct MainScreenDebug: View{
    @EnvironmentObject var app: RealmSwift.App
    
    var body: some View {
        VStack {
            MainScreen()
            Text(app.currentUser?.description ?? "Not logged in")
        }
    }
}


