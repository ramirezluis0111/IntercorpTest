//
//  Login.swift
//  IntercorpTest
//
//  Created by Ramirez Luis on 24/06/2021.
//

import SwiftUI

struct Login: View {
    @ObservedObject var usr: userRegister
    
    var body: some View {
        VStack {
            if !usr.downloadComplete && !usr.userAuth {
                AnimationShape()
            } else {
                if usr.completeAuth {
                    PrincipalView(usr: usr)
                        .onChange(of: usr.completeAuth, perform: { value in
                            print("usr.completeAuth: \(usr.completeAuth)")
                        })
                } else {
                    PrincipalAuth(usr: usr)                    .navigationBarHidden(true)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                }
                
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(usr: userRegister())
    }
}
