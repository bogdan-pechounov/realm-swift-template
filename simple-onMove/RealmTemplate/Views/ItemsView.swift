//
//  Items.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct ItemsView: View {
    
    @ObservedResults(Item.self, sortDescriptor: SortDescriptor(keyPath: "order", ascending: true)) var items
    
    @Environment(\.realm) var realm
    
    var body: some View {
        List {
            ForEach(items) { item in
                ItemView(item: item)
            }
            .onDelete(perform: $items.remove)
            .onMove(perform: onMove)
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
