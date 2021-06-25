//
//  ContentView.swift
//  IntercorpTest
//
//  Created by Ramirez Luis on 20/06/2021.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct ContentView: View {
    @ObservedObject private var user = userRegister()
    @State var showAction: Bool = false
    
    var body: some View {
        ZStack {
            if !user.change {
                AnimationShape()
            } else {
                NavigationView {
                    if !user.userAuth && user.change {
                        LoginFB(isShown: self.$showAction)
                            .frame(width: 100, height: 28)
                            .onChange(of: showAction, perform: { value in
                                user.detectUser()
                            })
                    } else if user.userAuth && user.change {
                        Login(usr: user)
                    }
                }
            }
        }
        .onAppear{
            user.detectUser()
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12")
            ContentView()
                .previewDevice("iPhone 8")
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}

