//
//  LoginWithApple.swift
//  RealmTemplate
//
//  Created by Bogdan on 2023-07-16.
//

import SwiftUI
import AuthenticationServices
import RealmSwift

struct LoginWithApple: View {
    
    @EnvironmentObject var app: RealmSwift.App
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorisation successful")
                switch authResults.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    if let idToken = credential.identityToken {
                        if let idTokenString = String(data: idToken, encoding: .utf8) {
                            loginWithApple(idToken: idTokenString)
                            dismiss() // TODO
                        }
                    }
                default:
                    break
                }
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
            }
        }
        .frame(height: 50)
        .padding()
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        
    }
    
    func loginWithApple(idToken: String){
        // Fetch IDToken via the Apple SDK
        let credentials = Credentials.apple(idToken: idToken)
        app.login(credentials: credentials) { (result) in
            switch result {
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            case .success(let user):
                print("Successfully logged in as user \(user)")
                // Now logged in, do something with user
                // Remember to dispatch to main if you are doing anything on the UI thread
            }
        }
    }
}

struct LoginWithApple_Previews: PreviewProvider {
    static var previews: some View {
        LoginWithApple()
    }
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
