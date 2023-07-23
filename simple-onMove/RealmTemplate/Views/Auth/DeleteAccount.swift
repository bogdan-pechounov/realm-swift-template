//
//  DeleteUser.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-16.
//

import SwiftUI
import RealmSwift

struct DeleteAccount: View {
    
    @State private var isPresented = false
    @State private var error: Error?
    
    @EnvironmentObject var app: RealmSwift.App
    
    var body: some View {
        Button(role: .destructive) {
            isPresented = true
        } label: {
//            Text("Delete Account")
            Label("Delete Account", systemImage: "trash.fill")
        }
        .confirmationDialog("Are you sure?", isPresented: $isPresented) {
            Button(role: .destructive) {
                app.currentUser?.delete { error in
                    self.error = error
                }
            } label: {
                Text("Delete Account")
            }
        }
        .errorAlert(error: $error)
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        return alert(
            error.wrappedValue?.localizedDescription ?? "",
            isPresented: .constant(error.wrappedValue != nil))
        {
            Button("OK") {
                error.wrappedValue = nil
            }
        }
    }
}

struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount()
    }
}
