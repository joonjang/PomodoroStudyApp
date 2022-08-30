//
//  PomodoroStudyApp.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-06-03.
//

import SwiftUI

@main
struct PomodoroStudyApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
