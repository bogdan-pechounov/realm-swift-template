//
//  Realm.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import RealmSwift


func printRealmStudioPath(){
    if let realm = try? Realm() {
        print("REALM STUDIO PATH:", realm.configuration.fileURL!)
    }
}
