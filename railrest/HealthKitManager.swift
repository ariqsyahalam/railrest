//
//  HealthKitManager.swift
//  railrest
//
//  Created by Reyhan Ariq Syahalam on 01/04/24.
//

import Foundation
import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    private init() {}

    // Permintaan izin untuk mengakses data HealthKit
    func requestSleepAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available")
            completion(false)
            return
        }

        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sleep Analysis type is not available")
            completion(false)
            return
        }

        healthStore.requestAuthorization(toShare: [], read: [sleepType]) { success, error in
            if let error = error {
                print("Error requesting HealthKit authorization: \(error.localizedDescription)")
            }
            completion(success)
        }
    }

    // Fetch seluruh data tidur
    func fetchSleepData(completion: @escaping ([HKCategorySample]?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil)
            return
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching sleep data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                let sleepSamples = samples as? [HKCategorySample]
                completion(sleepSamples)
            }
        }

        healthStore.execute(query)
    }

    // Hitung durasi rata-rata dari tidur ringan
    func calculateAverageLightSleepDuration(from sleepData: [HKCategorySample]) -> TimeInterval? {
        // Filter untuk data tidur ringan, ini tergantung pada bagaimana data disimpan dan ditandai di HealthKit
        // HealthKit secara default tidak membedakan antara tidur ringan dan tidur dalam
        // Contoh: kita hanya menggunakan semua data 'Asleep' sebagai 'Light Sleep'
        let lightSleepData = sleepData.filter { $0.value == HKCategoryValueSleepAnalysis.asleep.rawValue }

        guard !lightSleepData.isEmpty else { return nil }

        // Hitung total durasi
        let totalDuration = lightSleepData.reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }

        // Hitung rata-rata durasi
        let averageDuration = totalDuration / Double(lightSleepData.count)
        
        return averageDuration
    }
    
    func calculateFirstPhaseLightSleepDuration(from sleepData: [HKCategorySample]) -> TimeInterval? {
        // Urutkan sampel berdasarkan waktu mulai
        let sortedSleepData = sleepData.sorted { $0.startDate < $1.startDate }

        // Temukan indeks pertama untuk "Asleep" setelah "InBed"
        if let firstAsleepIndex = sortedSleepData.firstIndex(where: { $0.value == HKCategoryValueSleepAnalysis.asleep.rawValue }),
           let firstInBedIndex = sortedSleepData.firstIndex(where: { $0.value == HKCategoryValueSleepAnalysis.inBed.rawValue }),
           firstAsleepIndex > firstInBedIndex {
            let firstAsleepSample = sortedSleepData[firstAsleepIndex]
            return firstAsleepSample.endDate.timeIntervalSince(firstAsleepSample.startDate)
        }
        
        return nil
    }

}

