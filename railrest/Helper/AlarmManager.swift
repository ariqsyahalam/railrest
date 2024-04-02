//
//  AlarmManager.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//

import Foundation
import AVFoundation
import AudioToolbox

class AlarmManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var alarmStarted: Bool = false
        
    private var audioPlayer: AVAudioPlayer?
    
    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "wav") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1  //Set infinite looping
            audioPlayer?.play()
            isPlaying = true
            alarmStarted = true
            
//            UserDefaults.standard.set(true, forKey: "isPlaying")
            print("Alarm sound started")

        } catch {
            print("Error playing alarm sound: \(error.localizedDescription)")
        }
    }
    
    func stopAlarmSound() {
        audioPlayer?.stop()
        isPlaying = false
        alarmStarted = false
        
//        UserDefaults.standard.set(false, forKey: "isPlaying")
        print("Alarm sound stopped")

    }

}


