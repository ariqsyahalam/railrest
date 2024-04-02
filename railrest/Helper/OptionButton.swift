//
//  OptionButton.swift
//  RailRest
//
//  Created by Bunga Prameswari on 01/04/24.
//

import SwiftUI

struct OptionButton: View {
    let imageName: String
    let label: String
    let color: Color
    let foreColor: Color
    let labelColor: Color
    
    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .padding(10)
                .overlay(
                    Image(systemName: imageName)
                        .foregroundColor(foreColor)
                        .font(.system(size: 30))
                )
                .frame(width: 80, height: 80)
            Text(label)
                .font(.subheadline)
                .foregroundColor(labelColor)
        }
    }
}

#Preview {
    OptionButton(imageName: "cloud.rain", label: "Rain", color: .white, foreColor: Color(hex: "3B4192"), labelColor: .white)
}
