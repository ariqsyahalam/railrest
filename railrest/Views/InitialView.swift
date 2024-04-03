//
//  InitialView.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//

import SwiftUI
import UIKit

struct InitialView: View {
    @State private var isOngoingViewActive = false
    @EnvironmentObject var alarmManager: AlarmManager
    @State private var averageLightSleepDuration: TimeInterval = 0
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center, spacing: 13) {
                    Spacer()
                    Image("home_logo")
                    VStack(alignment: .center, spacing: 13) {
                        Text("Help you to get power nap based on your personalize sleep behavior")
                            .font(Font.custom("SF Pro", size: 17))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 297, alignment: .top)
                    }.padding(0)
                    Spacer()
                    NavigationLink(destination: OngoingView()) {
                        
                        Text("Start Power Nap")
                            .font(Font.custom("SF Pro", size: 17))
                            .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.39))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 361, alignment: .center)
                    .background(.white)
                    .cornerRadius(12)
                    
                    // Bottom Space
                    Spacer()
                        .frame(minHeight: 16, idealHeight: 40, maxHeight: .infinity)
                        .fixedSize()
                }
                .padding()
            }
            .frame(width: 393, height: 852)
            .background(Color(red: 0.12, green: 0.14, blue: 0.39))
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(alarmManager)
        .onAppear{
            fetchSleepData()
        }
    }

    func fetchSleepData() {
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
    
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        return formatter.string(from: duration) ?? "N/A"
    }
    
}



#Preview {
    InitialView()
        .environmentObject(AlarmManager())
}
