//
//  MainScreen.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI

struct MainScreen: View {
    @State private var showAddItem = false
    
    var body: some View {
        // Navigation
        NavigationView {
            // Items
            ItemsView()
                .navigationTitle("Items")
                .toolbar {
                    // Add item
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddItem = true
                        } label: {
                            Label("Add item", systemImage: "plus")
                        }
                    }
                    
                    //Edit
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                    // Log in
                    ToolbarItem(placement: .navigationBarLeading) {
                        LoginView()
                    }
                    
                    // Add multiple
                    ToolbarItem(placement: .navigationBarLeading) {
                        AddItems()
                    }
                }
                .sheet(isPresented: $showAddItem) {
                    // Sheet
                    AddItemView()
                }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
