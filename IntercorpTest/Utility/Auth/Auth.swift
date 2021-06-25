//
//  Auth.swift
//  IntercorpTest
//

import Foundation
import SwiftUI
import FBSDKLoginKit
import Firebase

struct LoginFB: UIViewRepresentable {
    @Binding var isShown: Bool
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return LoginFB.Coordinator(isShown: $isShown)
    }
    
    func makeUIView(context: UIViewRepresentableContext<LoginFB>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        button.delegate = context.coordinator
        return button
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        @Binding var isShown: Bool
        
        init(isShown: Binding<Bool>) {
            _isShown = isShown
        }

        func loginButton(_ loginButton: FBLoginButton,
                         didCompleteWith result: LoginManagerLoginResult?,
                         error: Error?) {

            if error != nil {
                print((error?.localizedDescription)!)
            } else {
                self.isShown = true
                
                if AccessToken.current != nil {
                    let credential = FacebookAuthProvider.credential(
                        withAccessToken: AccessToken.current!.tokenString)
                    
                    Auth.auth().signIn(with: credential,
                                       completion: {(res, err) in
                        if err != nil {
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        print("Success")

                    })
                }
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            print("LogOut")
            
            let loginManager = LoginManager()
            loginManager.logOut()
            
            try? Auth.auth().signOut()
        }
        
    }

}
