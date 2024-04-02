//
//  Color.swift
//  RailRest
//
//  Created by Bunga Prameswari on 01/04/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        // Scan the hexadecimal value
        scanner.scanHexInt64(&rgbValue)

        // Extract the red, green, and blue components
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        // Initialize the Color with extracted components
        self.init(red: red, green: green, blue: blue)
    }
}

