//
//  AddItems.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-08-03.
//

import SwiftUI
import RealmSwift

struct AddItems: View {
    
    @ObservedResults(Item.self) private var items

    var body: some View {
        Button {
            $items.remove(atOffsets: IndexSet(items.indices))
            for name in ["A", "B", "C"] {
                $items.append(Item(name: name, order: 0))
            }
            for name in ["D", "E"] {
                $items.append(Item(name: name, order: 1))
            }
        } label: {
            Text("Reset")
        }
    }
}

struct AddItems_Previews: PreviewProvider {
    static var previews: some View {
        AddItems()
    }
}
