//
//  TimerManager.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    @Published var alarmTriggered: Bool = false

    private var timer: Timer?
    private let alarmManager = AlarmManager()
    
    func startTimer() {
        timer?.invalidate()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
            if self.elapsedTime >= 10 && !self.alarmTriggered { //ubah ini karena yg jd patokan adalah heartrate <50
                self.alarmTriggered = true
                self.alarmManager.playAlarmSound()
                
                print("Timer started")

            }
        }
    
    }
    
    func stopTimer() {
        timer?.invalidate()
        isRunning = false
        self.alarmManager.stopAlarmSound() //tambah ini
        
        print("Timer stopped")
    }
    
    func resetTimer() {
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        alarmTriggered = false
    }
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
