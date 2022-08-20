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
            
            HStack {
                Button("Pomodoro") {
                    vm.seconds = 25.0 * 60
                }
                
                Button("Short Break") {
                    vm.seconds = 5.0 * 60
                }
                Button("Long Break") {
                    vm.seconds = 15.0 * 60
                }
            }
            .buttonStyle(.bordered)
            
            
            Text("\(vm.time)")
                .font(.system(size: 100))
                .alert("Time Complete", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // code
                    }
                }
                

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
