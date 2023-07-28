//
//  LoginAnonymous.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-16.
//

import SwiftUI
import RealmSwift

struct LoginAnonymous: View {
    
    @EnvironmentObject var app: RealmSwift.App

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            anonymousLogin()
        } label: {
            Text("Login anonymously")
        }
    }
    
    func anonymousLogin(){
        Task {
            do {
                let user = try await app.login(credentials: .anonymous)
                print("Logged in as user with id: \(user.id)")
                // dismiss()
            } catch {
                print("Failed to log in: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginAnonymous_Previews: PreviewProvider {
    static var previews: some View {
        LoginAnonymous()
    }
}
