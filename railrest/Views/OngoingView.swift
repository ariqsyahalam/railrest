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
                        VStack {
                            Image("nap")
                                .resizable()
                                .frame(width: 220, height: 215)
                            
                            Text("Power Napping for...")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            TimerView(timerManager: timerManager)
                                .foregroundColor(.white)
                            
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
                        

                        Text("Enjoy and relax to get a better sleep")
                            .font(.subheadline)
//                            .padding()
                            .foregroundColor(Color(hex: "63FFF6"))
                        
                        Text("Calm Rain")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
