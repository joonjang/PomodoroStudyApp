//
//  ContentView.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-06-03.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {

        VStack {
            
            // Time configuration buttons
            HStack {
                Button("Pomodoro") {
                    vm.seconds = 25.00 * 60
                    vm.chosen = 25.0 * 60
                    vm.climbing = true
                }
                
                Button("Short Break") {
                    vm.seconds = 5.0 * 60
                    vm.chosen = 5.0 * 60
                    vm.climbing = false
                }
                Button("Long Break") {
                    vm.seconds = 15.0 * 60
                    vm.chosen = 15.0 * 60
                    vm.climbing = false
                }
                
                //DEBUG
                VStack{
                    //Climb
                    Button("D1") {
                        vm.seconds = 30.0
                        vm.chosen = 30.0
                        vm.climbing = true
                    }
                    //Rest
                    Button("D2") {
                        vm.seconds = 10.0
                        vm.chosen = 10.0
                        vm.climbing = false
                    }
                }
            }
            .buttonStyle(.bordered)
            .disabled(vm.isActive)
            
            // Time + Complete alert trigger
            Text("\(vm.time)")
                .font(.system(size: 100))
                .alert("Time Complete", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // code
                    }
                }
                

            // Start/Pause buttons
            HStack {
                Button("Start") {
                    vm.start(sec: vm.seconds)
                }
                .disabled(vm.isActive)
                
                Spacer()
                
                Button("Pause", role: .destructive) {
                    vm.pause()
                }
                .disabled(!vm.isActive)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            // Progress visual
            VStack {
                if(vm.climbing) {
                    ProgressView(value: vm.chosen - vm.seconds, total: vm.chosen)
                        .rotationEffect(.degrees(-45))
                } else {
                    ProgressView(value: vm.chosen - vm.seconds, total: vm.chosen)
                }
                Rectangle()
                    .frame(height: 5)
                    .rotationEffect(.degrees(-45))
                Rectangle()
                    .frame(height: 5)
            }
            Spacer()
        }
        .onReceive(timer) { _ in
            vm.updateCountDown()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
