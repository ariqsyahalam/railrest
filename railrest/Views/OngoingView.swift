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
    
    @StateObject var timerManager: TimerManager
    
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
                            
                            
//                            Button(action: {
//                                presentationMode.wrappedValue.dismiss()
//                            }) {
//                                Text("Cancel Nap")
//                                    .font(.title3)
//                                    .fontWeight(.semibold)
//                                    .padding(15)
//                                    .background(RoundedRectangle(cornerRadius: 40).fill(.yellow))
//                                    .foregroundColor(Color(hex: "101A4D"))
//                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 0)
                        .frame(width: 360, height: 360, alignment: .center)
                        .background(Color(red: 0.16, green: 0.19, blue: 0.52))
                        .cornerRadius(231)
                        
                        
                        Text("Enjoy and relax to get a better sleep")
                            .font(.subheadline)
                        //                            .padding()
                            .foregroundColor(Color(hex: "63FFF6"))
                        
                        Text("Calm Rain")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        //                            .padding(.top, 20)
                        
                        Text("is playing..")
                            .foregroundColor(.white)
                        
                        HStack(spacing: 5) {
                            OptionButton(imageName: "cloud.rain", label: "Rain", color: .yellow, foreColor: Color(hex: "101A4D"), labelColor: .yellow).fontWeight(.bold)
                            OptionButton(imageName: "water.waves", label: "Waves", color: Color(hex: "3B4192"), foreColor: .white, labelColor: .white)
                            OptionButton(imageName: "radio", label: "Static", color: Color(hex: "3B4192"), foreColor: .white, labelColor: .white)
                            OptionButton(imageName: "nosign", label: "None", color: Color(hex: "3B4192"), foreColor: .white, labelColor: .white)
                        }
                        .padding()
                    }
                    .padding(15)
                    .navigationBarBackButtonHidden(true)
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
