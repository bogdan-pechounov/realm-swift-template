//
//  ItemView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct ItemView: View {
    
    @ObservedRealmObject var item: Item
        
    var body: some View {
        TextField("Name", text: $item.name)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(name: "Name"))
    }
}
