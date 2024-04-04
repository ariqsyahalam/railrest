//
//  OngoingView.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//

import SwiftUI

struct OngoingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var alarmManager: AlarmManager
    @State private var alarmStarted = false
    @State private var activeSoundType: String? = nil
    @State private var currentPlayingSound: String?
    
    @StateObject var timerManager: TimerManager
    
    @State private var isShowingFinalView = false // New state for navigation
    
    init() {
        _timerManager = StateObject(wrappedValue: TimerManager())
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                ZStack {
                    VStack {
                        VStack (alignment: .center, spacing: 10) {
                            TimerView(timerManager: timerManager)
                                .foregroundColor(.white)
                            
                            Text("Remaining Nap Time")
                                .font(
                                    Font.custom("SF Pro", size: 20)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.white)
                            
                            Text("Your Optimal Nap Time is 12 Minutes")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(.white.opacity(0.65))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 0)
                        .frame(width: 360, height: 360, alignment: .center)
                        .background(Color(red: 0.16, green: 0.19, blue: 0.52))
                        .cornerRadius(231)
                        
                        
                        Text("Choose the ambience to help you sleep")
                            .font(.body)
                            .padding(16)
                            .foregroundColor(.white)
                        
                        
                        VStack {
                            HStack {
                                OptionButton(imageName: "cloud.rain", label: "Rain", soundType: "rain", activeSoundType: $activeSoundType, currentPlayingSound: $currentPlayingSound)
                                OptionButton(imageName: "radio", label: "Static", soundType: "static", activeSoundType: $activeSoundType, currentPlayingSound: $currentPlayingSound)
                                OptionButton(imageName: "nosign", label: "None", soundType: "none", activeSoundType: $activeSoundType, currentPlayingSound: $currentPlayingSound)
                            }
                        }
                        .onAppear {
                            // Pastikan activeSoundType tidak nil
                            if activeSoundType == nil {
                                activeSoundType = "none"
                            }
                        }
                    }
                    .padding(15)
                    .navigationBarBackButtonHidden(true)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color(hex: "1E2363"))
            }
        }
        .alert(isPresented: $timerManager.showingAlert) {
            Alert(title: Text("Time To Wake Up!"),
                  message: Text("Your Power Nap Session has been completed"),
                  dismissButton: .default(Text("I’m Awake")){
                timerManager.setAlertDismissed(to: true)
                isShowingFinalView = true // Navigate to FinalView
            }
            )
        }
        .background(
            NavigationLink(destination: FinalView(), isActive: $isShowingFinalView) {
                EmptyView()
            }
        )
        
    }
}

#Preview {
    OngoingView()
        .environmentObject(AlarmManager())
}
