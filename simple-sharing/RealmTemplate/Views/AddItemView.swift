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
    @FocusState var focused

    @ObservedResults(Item.self) private var items
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var app: RealmSwift.App
    
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($focused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        focused = true
                    }
                }
                .submitLabel(.done)
                .onSubmit {
                    submit()
                }
            Button {
                submit()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    func submit(){
        // Add item to collection
        let item = Item(name: name, userId: app.currentUser?.id)
        $items.append(item)
        
        dismiss()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
