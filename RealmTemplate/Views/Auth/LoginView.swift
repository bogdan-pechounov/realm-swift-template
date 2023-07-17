//
//  LoginView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var app: RealmSwift.App
    
    @State private var isPresented = false

    var body: some View {
        if let user = app.currentUser {
            Button {
                logout(user)
            } label: {
                Text("Logout")
            }
        } else {
            Button {
                isPresented = true
            } label: {
                Text("Login")
            }
            .sheet(isPresented: $isPresented) {
                LoginAnonymous()
                LoginWithApple()
            }
        }
    }
    
    
    func logout(_ user: User){
        Task {
            do {
                try await user.logOut()
                print("User logged out")
            } catch {
                print("Error logging out: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Realm.app)
    }
}
