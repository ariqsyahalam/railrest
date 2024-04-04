//
//  railrestApp.swift
//  railrest
//
//  Created by Reyhan Ariq Syahalam on 01/04/24.
//

import SwiftUI

@main
struct railrestApp: App {
    let alarmManager = AlarmManager() // Initialize your AlarmManager
    
    var body: some Scene {
        WindowGroup {
            InitialView().environmentObject(alarmManager) // Provide the AlarmManager environment object to your ContentView
        }
    }
}

