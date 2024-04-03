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
    let soundType: String
    
    private let noiseManager = NoiseManager()
    @Binding var activeSoundType: String?
    @Binding var currentPlayingSound: String?
    
    var body: some View {
        VStack {
            Circle()
                .fill(.quaternary)
                .overlay(
                    Circle()
                        .stroke(activeSoundType == soundType ? .white : .clear, lineWidth: 4)
                        .frame(width: 60, height: 60)
                )
                .padding(10)
                .overlay(
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                )
                .frame(width: 75, height: 75)
                .onTapGesture {
                    toggleSound()
                }
            Text(label)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
    
    private func toggleSound() {
        if activeSoundType != soundType {
            noiseManager.playNoise(soundType: soundType)
            activeSoundType = soundType
            
            if let previousPlayingSound = currentPlayingSound {
                noiseManager.stopNoise(soundType: previousPlayingSound)
            }
            currentPlayingSound = soundType
        } else {
            noiseManager.stopNoise(soundType: soundType)
            activeSoundType = nil
            currentPlayingSound = nil
        }
    }
}



#Preview {
    OptionButton(
        imageName: "cloud.rain",
        label: "Rain",
        soundType: "rain",
        activeSoundType: .constant(nil),
        currentPlayingSound: .constant(nil)
    )
}
