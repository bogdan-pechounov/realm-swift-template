//
//  AddItemView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct AddItemView: View {
    
    @State private var name = ""
    
    @ObservedResults(Item.self) private var items
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var app: RealmSwift.App
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            
            Button {
                // Add item to collection
                let order = (items.max(of: \Item.order) ?? 0)
                let item = Item(name: name, order: order, userId: app.currentUser?.id)
                $items.append(item)
                
                dismiss()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
