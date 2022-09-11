//
//  ContentViewModel.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-17.
//

import Foundation

// code help from:
// https://www.youtube.com/watch?v=NAsQCNpodPI&list=LL&index=2
extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var selectedValue: Int? = 0
        @Published var finished: Bool = false
        @Published var lastAddedCount: Int = 25
        
        @Published var chosenIndex: Float = 25.0
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "25:00"
        @Published var climbing = true
        @Published var seconds: Float = 25.0 * 60 {
            didSet{
                // Doesn't account for setting seconds, doesn't need to
                self.time = "\(Int(seconds)/60):00"
                
                //TODO: DEBUG: accounts for seconds
//                self.time = "\(Int(seconds)/60):\(Int(seconds)%60)"
            }
        }
        
        private var initialTime: Float = 0
        private var endDate = Date()
        
        func start(sec: Float) {
            self.initialTime = seconds
            self.endDate = Date()
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .second, value: Int(seconds), to: endDate)!
        }
        
        func pause() {
            self.isActive = false

        }
        
        func reset() {
            self.seconds = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(seconds)/60):00"
        }
        
        
        // event listener function runs only when isActive is true
        func updateCountDown() {
            guard isActive else { return }
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0{
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.seconds = Float(minutes * 60 + seconds)
            self.time = String(format: "%d:%02d", minutes, seconds)
            
            self.selectedValue = Int(self.chosenIndex - (self.seconds/60))
            // TODO: debugging, set to seconds increments
//            self.selectedValue = Int(self.chosenIndex - self.seconds)
        }
    }
}
