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
        for index in indexSet {
            detectDuplicates(from: index, to: destination)
            move(items: sortedItems, from: index, to: destination)
        }
    }
    
    var sortedItems: Results<Item> {
        return realm.objects(Item.self).sorted(byKeyPath: "order", ascending: true)
    }
    
    func detectDuplicates(from index: Int, to destination: Int){
        let itemToMove = items[index]
        displaceDuplicates(items.where { item in
            item.order == itemToMove.order
        })
        let orderAtDestination = orderAtDestination(items: sortedItems, destination)
        displaceDuplicates(items.where { item in
            item.order == orderAtDestination
        })
    }
    
    func displaceDuplicates(_ duplicates: Results<Item>){
        print("DUPLICATES", duplicates)
        try? realm.write {
            for i in 1..<duplicates.count {
                if let item = duplicates[i].thaw() {
                    let order = item.order + i
                    for item in sortedItems.where({ item in
                        item.order >= order
                    }) {
                        item.thaw()?.order += 1
                    }
                    item.order = order
                }
            }
        }
    }
    
    func move(items: Results<Item>, from index: Int, to destination: Int) {
        let itemToMove = items[index]
        let orderAtDestination = orderAtDestination(items: items, destination)
        
        // move item down
        if itemToMove.order < orderAtDestination {
            let start = itemToMove.order + 1
            let end = orderAtDestination - 1
            let itemsToDisplace = items.where { item in
                item.order.contains(start...end)
            }
            try? realm.write {
                // displace upwards
                itemsToDisplace.forEach { item in
                    item.thaw()?.order -= 1
                }
                // save
                itemToMove.thaw()?.order = end
            }
        }
        // move item up
        else if itemToMove.order > orderAtDestination {
            let start = orderAtDestination
            let end = itemToMove.order - 1
            let itemsToDisplace = items.where { item in
                item.order.contains(start...end)
            }
            try? realm.write {
                // displace downwards
                itemsToDisplace.forEach { item in
                    item.thaw()?.order += 1
                }
                // save
                itemToMove.thaw()?.order = start
            }
        }
    }
    
    
    func orderAtDestination(items: Results<Item>, _ destination: Int) -> Int{
        if destination < items.count {
            return items[destination].order
        }
        return (items.max(of: \Item.order) ?? 0) + 1
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
