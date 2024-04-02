//
//  HealthStoreManager.swift
//  railrest
//
//  Created by Reyhan Ariq Syahalam on 01/04/24.
//


import Foundation
import HealthKit
import UserNotifications

class HealthStoreManager: ObservableObject {
    var healthStore: HKHealthStore?
    var heartRateQuery: HKQuery?
    var lastAnchor: HKQueryAnchor?
    @Published var currentHeartRate: Double = 0.0
    @Published var isDeepSleep: Bool = false
    @Published var lastHeartRateDate: Date?
    @Published var averageHeartRate: Double = 0.0
    
    // Array untuk menyimpan 3 sampel detak jantung terakhir
    var lastThreeHeartRates: [Double] = []
    
    init() {
        print("HealthStoreManager initialized.")
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            print("Requesting HealthKit authorization...")
            requestAuthorization()
        } else {
            print("HealthKit is not available on this device.")
        }
    }
    
    func startSession() {
        print("Session started.")
        startHeartRateMonitoring()
    }
    
    func endSession() {
        print("Session ended.")
        stopHeartRateMonitoring()
    }
    
    
    func requestAuthorization() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            print("Unable to create heart rate quantity type.")
            return
        }
        
        healthStore?.requestAuthorization(toShare: [], read: [heartRateType]) { success, error in
            if success {
                print("HealthKit authorization granted.")
                self.startHeartRateMonitoring()
            } else {
                print("HealthKit authorization denied.")
                if let error = error {
                    print("Authorization error: \(error.localizedDescription)")
                }
            }
        }
        
        // Meminta izin notifikasi
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func startHeartRateMonitoring() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            print("Heart rate type is unavailable.")
            return
        }
        
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: lastAnchor, limit: HKObjectQueryNoLimit) { _, samples, _, newAnchor, _ in
            self.processHeartRateSamples(samples: samples)
            self.lastAnchor = newAnchor
        }
        
        query.updateHandler = { _, samplesOrNil, _, newAnchor, _ in
            // Gunakan optional binding untuk unwrap 'samplesOrNil'
            if let samples = samplesOrNil, !samples.isEmpty {
                self.processHeartRateSamples(samples: samples)
                self.lastAnchor = newAnchor
            }
        }
        
        
        healthStore?.execute(query)
        heartRateQuery = query
        print("Heart rate monitoring started.")
    }
    
    func processHeartRateSamples(samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample], let latestSample = heartRateSamples.first else {
            print("No heart rate samples available.")
            return
        }
        
        let heartRate = latestSample.quantity.doubleValue(for: HKUnit(from: "count/min"))
        
        // Gunakan DispatchQueue.main.async untuk memastikan UI update di main thread
        DispatchQueue.main.async {
            // Menambahkan sampel terbaru ke array dan memastikan hanya 3 sampel terakhir yang disimpan
            self.lastThreeHeartRates.append(heartRate)
            if self.lastThreeHeartRates.count > 3 {
                self.lastThreeHeartRates.removeFirst(self.lastThreeHeartRates.count - 3)
            }
            
            // Hitung rata-rata dari 3 sampel terakhir
            let averageHeartRate = self.lastThreeHeartRates.reduce(0, +) / Double(self.lastThreeHeartRates.count)
            self.averageHeartRate = averageHeartRate  // Update the average heart rate
            
            self.currentHeartRate = heartRate  // Update the current heart rate
            self.lastHeartRateDate = latestSample.endDate  // Update the last heart rate date
            
            // If you have any other UI related updates, add them here.
        }
    }
    
    func determineSleepPhase(heartRate: Double) {
        // Gunakan rata-rata dari 3 sampel terakhir untuk menentukan fase tidur dalam
        isDeepSleep = heartRate < 60   // Angka 75 bisa disesuaikan berdasarkan kriteria Anda
        if isDeepSleep {
            print("User is in deep sleep based on average of last 3 heart rates.")
            triggerSoundAlert()
        }
    }
        func triggerSoundAlert() {
            let content = UNMutableNotificationContent()
            content.title = "Deep Sleep Detected"
            content.body = "Your body is now in deep sleep phase."
            content.sound = UNNotificationSound.default  // Gunakan suara default atau spesifik
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)  // Trigger segera
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
        
        func stopHeartRateMonitoring() {
            if let query = heartRateQuery {
                healthStore?.stop(query)
                heartRateQuery = nil
                print("Heart rate monitoring stopped.")
            }
        }
    }
    

