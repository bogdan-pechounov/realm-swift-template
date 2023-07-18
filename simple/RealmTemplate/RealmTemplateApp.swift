//
//  RealmTemplateApp.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI

@main
struct RealmTemplateApp: App {
        
    init(){
        printRealmStudioPath()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
