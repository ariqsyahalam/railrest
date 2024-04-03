//
//  SummaryView.swift
//  railrest
//
//  Created by Evelyn Santoso on 03/04/24.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                VStack(alignment: .center, spacing: 13) {
                    Spacer()
                    VStack(alignment: .center, spacing: 16.0) {
                        Text("You've Slept For")
                            .font(Font.custom("SF Pro", size: 34))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 297, alignment: .top)
                        
                        //ganti variabel
                        Text("10s")
                            .font(.system(size: 40))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 297, alignment: .top)
                    }.padding()
                    
                    Spacer()
                    NavigationLink(destination: InitialView()) {
                        
                        Text("Back to Main Screen")
                            .font(Font.custom("SF Pro", size: 17))
                            .foregroundColor(.black)
                    }
                    
                  
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 361, alignment: .center)
                    .background(Color(hex:"FFCC00"))
                    .cornerRadius(12)
                    
                    // Bottom Space
                    Spacer()
                        .frame(minHeight: 16, idealHeight: 40, maxHeight: .infinity)
                        .fixedSize()
                }
                .padding()
            }
            .frame(width: 393, height: 852)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(hex : "036B46"), Color(hex : "2DAA7D")]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }


#Preview {
    SummaryView()
}
