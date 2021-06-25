//
//  PrincipalView.swift
//  IntercorpTest
//
//  Created by Ramirez Luis on 22/06/2021.
//

import SwiftUI

struct PrincipalView: View {
    @ObservedObject var usr: userRegister
    
    var body: some View {
        VStack {
            Text("Bienvenido a IntercorpTest!")
                .fontWeight(.medium)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .padding()
                .font(.system(size: 23))
            Text(
                (usr.dataDownload["data"] as? NSDictionary)!["name"] as? String ?? ""
            )
                .padding(60)
                .font(.system(size: 20))
            
            Button(action: {
                usr.loginButtonDidLogOut()
            }) {
                Text("Cerrar sesión")
            }
            .frame(width: 200, height: 50, alignment: .center)
            .accentColor(.white)
            .background(Color.init(hexStringToUIColor(hex: "0D5EAB")))
            .cornerRadius(25)
            .font(.system(size: 23))
            .padding(.top, 15)
        }
        .onAppear{
            usr.downloadUser()
        }
    }
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView(usr: userRegister())
    }
}
