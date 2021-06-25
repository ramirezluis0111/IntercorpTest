//
//  textField.swift
//  IntercorpTest
//

import Foundation
import UIKit
import SwiftUI

struct PlaceholderTextFieldStyle: TextFieldStyle {
    let placeholder: String
    
    @Binding var text: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.init(hexStringToUIColor(hex: "#89898E")))
            }
            configuration
        }
        .foregroundColor(.black)
        .font(.system(size: 18))
        .disableAutocorrection(true)
        .padding()
        .background(Color.init(hexStringToUIColor(hex: "#E3E3E8")))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .multilineTextAlignment(.center)
    }

}
