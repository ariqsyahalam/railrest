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
    @Published var averageLightSleepDuration: Double = 10
    @Published var showingAlert: Bool = false
    @Published var alertDismissed: Bool = false

    private var timer: Timer?
    private let alarmManager = AlarmManager()
    
    func startTimer() {
        elapsedTime = averageLightSleepDuration
        print(elapsedTime)
        fetchSleepData()
        print(elapsedTime)
        timer?.invalidate()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime -= 1
            if self.elapsedTime == 0 && !self.alarmTriggered { //ubah ini karena yg jd patokan adalah heartrate <50
                self.alarmTriggered = true
                self.alarmManager.playAlarmSound()
                self.stopTimer()
                print("Timer started")

            }
        }
    
    }
    
    func stopTimer() {
        timer?.invalidate()
        isRunning = false
        self.showingAlert = true
        
        print("Timer stopped")
    }
    
    func setAlertDismissed(to value: Bool) {
        alertDismissed = value
        self.alarmManager.stopAlarmSound() //tambah ini
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
    
    func fetchSleepData() {
        HealthKitManager.shared.requestSleepAuthorization { authorized in
            guard authorized else {
//                self.alertMessage = "HealthKit authorization was denied."
//                self.showingAlert = true
                return
            }
            
            HealthKitManager.shared.fetchSleepData { sleepData in
                if let sleepData = sleepData {
                    if let firstPhaseDuration = HealthKitManager.shared.calculateFirstPhaseLightSleepDuration(from: sleepData) {
                        self.averageLightSleepDuration = firstPhaseDuration
                        print()
                        print(firstPhaseDuration)
                    } else {
//                        self.alertMessage = "No Light Sleep data found for the first phase."
//                        self.showingAlert = true
                    }
                } else {
//                    self.alertMessage = "Failed to fetch sleep data."
//                    self.showingAlert = true
                }
            }
        }
    }

    
}
