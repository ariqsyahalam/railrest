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
                LinearGradient(gradient: Gradient(colors: [Color(hex: "1E2363"), Color(hex: "3D47C9")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Image("start")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Power Nap can energize you in a short time")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Make sure your belongings are safe")
                            .foregroundColor(.white)
                    }
                    
                    
                    NavigationLink(destination: OngoingView()) {
                        Text("Start Power Nap")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(25)
                            .background(RoundedRectangle(cornerRadius: 40).fill(.yellow))
                            .foregroundColor(Color(hex: "101A4D"))
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(alarmManager)
        //        .navigationBarItems(leading:
        //                        Image("railrest_white")
        //                            .resizable()
        //                            .aspectRatio(contentMode: .fit)
        //                            .frame(width: 120, height: 40) // Adjust size as needed
        //                    )
        
        
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
