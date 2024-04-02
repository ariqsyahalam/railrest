//
//  ContentView.swift
//  railrest
//
//  Created by Reyhan Ariq Syahalam on 01/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var averageLightSleepDuration: TimeInterval = 0
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sleep Data")
                .font(.headline)
            Text("Average Light Sleep Duration:")
            Text("\(formatDuration(averageLightSleepDuration))")
                .font(.title)
                .padding()
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    print(averageLightSleepDuration)
                }
        }.onAppear {
            fetchSleepData()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func fetchSleepData() {
        HealthKitManager.shared.requestSleepAuthorization { authorized in
            guard authorized else {
                self.alertMessage = "HealthKit authorization was denied."
                self.showingAlert = true
                return
            }

            HealthKitManager.shared.fetchSleepData { sleepData in
                if let sleepData = sleepData {
                    if let firstPhaseDuration = HealthKitManager.shared.calculateFirstPhaseLightSleepDuration(from: sleepData) {
                        self.averageLightSleepDuration = firstPhaseDuration
                    } else {
                        self.alertMessage = "No Light Sleep data found for the first phase."
                        self.showingAlert = true
                    }
                } else {
                    self.alertMessage = "Failed to fetch sleep data."
                    self.showingAlert = true
                }
            }
        }
    }


    private func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        return formatter.string(from: duration) ?? "N/A"
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


