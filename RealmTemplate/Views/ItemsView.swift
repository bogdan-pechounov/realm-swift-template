//
//  Items.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct ItemsView: View {
    
    @ObservedResults(Item.self) var items
        
    var body: some View {
        if items.isEmpty {
            Text("No items")
        } else {
            List {
                ForEach(items) { item in
                    ItemView(item: item)
                }
                .onDelete(perform: $items.remove)
            }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
