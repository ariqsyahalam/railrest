//
//  ContentView.swift
//  RailRest
//
//  Created by Bunga Prameswari on 30/03/24.
//
//

import SwiftUI

struct ContentView: View {
        @StateObject var alarmManager = AlarmManager()
    
    
        var body: some View {
            InitialView()
                .environmentObject(alarmManager)
        }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


