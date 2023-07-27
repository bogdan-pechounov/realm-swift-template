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
    
    func onMove(indexSet: IndexSet, destination: Int){
        for index in indexSet { // not sure how we can move more than one item at a time
            let itemToMove = items[index]
            let orderAtDestination = orderAtDestination(destination)
            
            // move item down
            if itemToMove.order < orderAtDestination {
                let start = itemToMove.order + 1
                let end = orderAtDestination - 1
                let itemsToDisplace = items.where { item in
                    item.order.contains(start...end)
                }
                // displace upwards
                itemsToDisplace.forEach { item in
                    if let item = item.thaw(){ // is there a way to use $items[index].order += 1
                        try! realm.write { // safe to catch exceptions?
                            item.order -= 1
                        }
                    }
                }
                // save
                if let itemToMove = itemToMove.thaw() {
                    try! realm.write {
                         itemToMove.order = end
                    }
                }
            }
            // move item up
            else if itemToMove.order > orderAtDestination {
                let start = orderAtDestination
                let end = itemToMove.order - 1
                let itemsToDisplace = items.where { item in
                    item.order.contains(start...end)
                }
                // displace downwards
                itemsToDisplace.forEach { item in
                    if let item = item.thaw(){
                        try! realm.write {
                            item.order += 1
                        }
                    }
                }
                // save
                if let itemToMove = itemToMove.thaw() {
                    try! realm.write {
                         itemToMove.order = start
                    }
                }
            }
        }
    }
    
    func orderAtDestination(_ destination: Int) -> Int{
        if destination < items.count {
            return items[destination].order
        }
        // if an array has 4 elements, there are 5 possible destinations
        // a destination of 4 means to move the item after the last item (with index 3)
        return (items.max(of: \Item.order) ?? 0) + 1
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
