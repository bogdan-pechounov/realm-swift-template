//
//  Move.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-08-05.
//

import Foundation
import RealmSwift

extension ItemsView {
    
    func onMove(indexSet: IndexSet, destination: Int){
        for index in indexSet {
            detectDuplicates(from: index, to: destination)
            move(from: index, to: destination)
        }
    }
    
    func detectDuplicates(from index: Int, to destination: Int){
        let itemToMove = items[index]
        displaceDuplicates(order: itemToMove.order)
        let orderAtDestination = orderAtDestination(destination)
        displaceDuplicates(order: orderAtDestination)
    }
    
    func displaceDuplicates(order: Int){
        let duplicates = items.where { item in
            item.order == order
        }
        if duplicates.count >= 2 {
            for i in 1..<duplicates.count { // exclude first
                try? realm.write {
                    
                    if let item = duplicates[i].thaw() {
                        let order = item.order + i
                        // displace up
                        for item in items.where({ item in
                            item.order >= order
                        }) {
                            item.thaw()?.order += 1
                        }
                        item.order = order
                    }
                }
            }
        }
    }
    
    func move(from index: Int, to destination: Int) {
        let itemToMove = items[index]
        let orderAtDestination = orderAtDestination(destination)
                
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
    
    
    func orderAtDestination(_ destination: Int) -> Int{
        if destination < items.count {
            return items[destination].order
        }
        return (items.max(of: \Item.order) ?? 0) + 1
    }
    
}


