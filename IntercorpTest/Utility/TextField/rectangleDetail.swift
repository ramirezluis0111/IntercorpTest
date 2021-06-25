//
//  rectangleDetail.swift
//  IntercorpTest
//


import Foundation
import UIKit
import SwiftUI

struct rectangleView: View {
    var colorSelect: String = ""
    
    var body: some View {
        Rectangle()
            .fill(Color.init(hexStringToUIColor(hex: colorSelect)))
            .frame(width: 40, height: 4)
            .cornerRadius(10)
    }
}
