//
//  PrincipalAuth.swift
//  GoUp_21
//
//  Created by Ramirez Luis on 22/06/2021.
//


import SwiftUI
import Firebase

struct PrincipalAuth: View {
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var age: String = ""
    @State private var dateOfBirth: String = ""
    
    @State private var errTextField = false
    @State private var opac: Double = 1
    
    @ObservedObject var usr: userRegister
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                VStack {
                    HStack {
                        Button(action: {
                            usr.loginButtonDidLogOut()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.init(hexStringToUIColor(hex: "#EB695B")))
                                .padding(.leading)
                            Text("Salir")
                                .font(.system(size: 20))
                                .foregroundColor(Color.init(hexStringToUIColor(hex: "#EB695B")))
                        })
                        
                        Spacer()
                    }.padding(.top, 70)
                    
                    
                    Text("Creación de Cliente")
                        .fontWeight(.regular)
                        .font(.system(size: 33))
                        .padding()
                    
                    Text("Se deben llenar todos los campos..")
                        .opacity(errTextField ? opac : 0)
                        .font(.system(size: 20))
                        .foregroundColor(.pink)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.5))
                        .padding()
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: heightScreem() / 2,
                    alignment: .center
                )
                .padding(.top)
                
                VStack(alignment: .leading){
                    Text("Nombre:")
                    ZStack(alignment: .bottom) {
                        TextField("", text: $name)
                            .textFieldStyle(
                                PlaceholderTextFieldStyle("Ingresa el nombre", text: $name))
                            .frame(width: 300, height: 35)
                            .onTapGesture {
                                errTextField = false
                            }
                    }.padding(.bottom, 15)
                    
                    Text("Apellido:")
                    ZStack(alignment: .bottom) {
                        TextField("", text: $surname)
                            .textFieldStyle(
                                PlaceholderTextFieldStyle("Ingresa el apellido", text: $surname))
                            .frame(width: 300, height: 35)
                            .onTapGesture {
                                errTextField = false
                            }
                    }.padding(.bottom, 15)
                    
                    Text("Edad:")
                    ZStack(alignment: .bottom) {
                        TextField("", text: $age)
                            .textFieldStyle(
                                PlaceholderTextFieldStyle("Ingresa la edad", text: $age))
                            .frame(width: 300, height: 35)
                            .onTapGesture {
                                errTextField = false
                            }
                    }.padding(.bottom, 15)
                    
                    Text("Fecha de nacimiento:")
                    ZStack(alignment: .bottom) {
                        TextField("", text: $dateOfBirth)
                            .textFieldStyle(
                                PlaceholderTextFieldStyle("DD/MM/AAAA", text: $dateOfBirth))
                            .frame(width: 300, height: 35)
                            .onTapGesture {
                                errTextField = false
                            }
                    }.padding(.bottom, 15)
                }
                
                VStack (alignment: .center){
                    Button(action: {
                        usr.updateValues(inputName: name,
                                         inputSurname: surname,
                                         inputAge: age,
                                         inputDateOfBirth: dateOfBirth)
                        
                        if usr.someEmpty() {
                            errTextField = true
                        } else {
                            usr.completeRegister()
                        }
                        
                    }) {
                        Text("Crear")
                    }
                    .frame(width: 200, height: 50, alignment: .center)
                    .accentColor(.white)
                    .background(Color.init(hexStringToUIColor(hex: "0D5EAB")))
                    .cornerRadius(25)
                    .font(.system(size: 23))
                    .padding(.top, 15)
                }
                .padding()
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(Color.white)
        .ignoresSafeArea(.all)
    }
}

struct PrincipalAuth_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalAuth(usr: userRegister())
    }
}
