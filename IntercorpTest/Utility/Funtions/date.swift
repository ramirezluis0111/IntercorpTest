//
//  date.swift
//  IntercorpTest
//


import Foundation

func todayString() -> String {
    let date = Date()
    let format = DateFormatter()
    
    format.dateFormat = "dd/MM/YYYY HH:mm"
    let today = format.string(from: date)
    
    return today
}
