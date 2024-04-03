//
//  SoundManager.swift
//  railrest
//
//  Created by Bunga Prameswari on 03/04/24.
//

import Foundation
import AVFoundation

class NoiseManager: ObservableObject {
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    func playNoise(soundType: String) {
        guard let noiseURL = Bundle.main.url(forResource: "\(soundType)", withExtension: "wav") else {
            return
        }
        
        if let audioPlayer = audioPlayers[soundType] {
            if !audioPlayer.isPlaying {
                audioPlayer.play()
                print("\(soundType) sound started")
            }
        } else {
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: noiseURL)
                audioPlayer.numberOfLoops = -1  // Set infinite looping
                audioPlayer.play()
                audioPlayers[soundType] = audioPlayer
                print("\(soundType) sound started")
            } catch {
                print("Error playing white noise: \(error.localizedDescription)")
            }
        }
    }
    
    func stopNoise(soundType: String) {
        if let audioPlayer = audioPlayers[soundType] {
            audioPlayer.stop()
            audioPlayers.removeValue(forKey: soundType)
            print("\(soundType) sound stopped")
        }
    }
}
