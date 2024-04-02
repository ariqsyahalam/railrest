//
//  AlarmView.swift
//  RailRest
//
//  Created by Bunga Prameswari on 31/03/24.
//

import SwiftUI

struct AlarmView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Text("Time is up!")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
    
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("I'm awake now")
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 2)))
                .foregroundColor(.green)
        }
        .padding()
    }
}

#Preview {
    AlarmView()
}
