//
//  LoginView.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-13.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    @EnvironmentObject var app: RealmSwift.App

    var body: some View {
        if let user = app.currentUser {
            Button {
                Task {
                    do {
                        try await user.logOut()
                        print("User logged out")
                    } catch {
                        print("Error logging out: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Logout")
            }
        } else {
            Button {
                Task {
                    do {
                        let user = try await app.login(credentials: .anonymous)
                        print("Logged in as user with id: \(user.id)")
                    } catch {
                        print("Failed to log in: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Login")
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
