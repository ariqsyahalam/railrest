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
    
    init() {
        _timerManager = StateObject(wrappedValue: TimerManager())
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                ZStack {
                    VStack {
                        VStack {
                            Image("nap")
                                .resizable()
                                .frame(width: 220, height: 215)
                            
                            Text("Power Napping for...")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            //                            TimerView(timerManager: timerManager)
                            //                                .foregroundColor(.white)
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Cancel Nap")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(15)
                                    .background(RoundedRectangle(cornerRadius: 40).fill(.yellow))
                                    .foregroundColor(Color(hex: "101A4D"))
                            }
                        }
                        .padding(.horizontal, 60)
                        .padding(.vertical, 25)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "3D47C9"), Color(hex: "1E2363")]), startPoint: .top, endPoint: .bottom))
                                .shadow(radius: 25)
                        )
                        
                        
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
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image("railrest_white")
                                .padding(.top)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color(hex: "1E2363"))
            }
        }
        
    }
}

#Preview {
    OngoingView()
        .environmentObject(AlarmManager())
}
