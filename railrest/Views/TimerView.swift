//
//  TimerView.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager: TimerManager

    var body: some View {
        VStack {
            Text(timerManager.formattedTime)
                .font(
                Font.custom("SF Pro", size: 64)
                .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

                .frame(width: 328, alignment: .top)
        }
        .onAppear {
            timerManager.startTimer()
        }
        .onDisappear {
            timerManager.stopTimer()
        }
    }
}

#Preview {
    TimerView(timerManager: TimerManager())
}
