//
//  ContentView.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-06-03.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    @EnvironmentObject var modelData: ModelData
    
//    let randomInt = Int.random(in: 0..<modelData.quotes.count)
    @State var randomInt = Int.random(in: 0...1642)

    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    func startProgress(climb: Bool, sec: Float) {
        
        if !vm.debug {
            vm.seconds = sec * 60
        } else {
            vm.seconds = sec
        }
        
        vm.chosenIndex = Float(modelData.progress[0].elapsed.count - 1)
        vm.climbing = climb
        vm.finished = false
        vm.lastAddedCount = Int(sec)
        vm.selectedValue = Int(vm.chosenIndex - (vm.seconds/60))
    }
    
    func deleteJson(){
        if(!vm.finished) {
            modelData.progress[0].elapsed.removeSubrange((modelData.progress[0].elapsed.count - vm.lastAddedCount)...(modelData.progress[0].elapsed.count - 1))
        }
    }
    
    func addJson(range2: Int, inc: Bool){
        for _ in 1...range2 {
            if inc {
                modelData.progress[0].elapsed.append(modelData.progress[0].elapsed.last! + 1)
            } else {
                modelData.progress[0].elapsed.append(modelData.progress[0].elapsed.last!)
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            // Time configuration buttons
            HStack {
                Button("Pomodoro") {
                    deleteJson()
                    addJson(range2: 25, inc: true)
                    startProgress(climb: true, sec: 25.0)
                    randomInt = Int.random(in: 0...1642)
                }
                
                Button("Short Break") {
                    deleteJson()
                    addJson(range2: 5, inc: false)
                    startProgress(climb: false, sec: 5.0)
                    randomInt = Int.random(in: 0...1642)

                }
                Button("Long Break") {
                    deleteJson()
                    addJson(range2: 15, inc: false)
                    startProgress(climb: false, sec: 15.0)
                    randomInt = Int.random(in: 0...1642)

                }
                
            }
            .buttonStyle(.bordered)
            .disabled(vm.isActive)
            
            // Time + Complete alert trigger
            Text("\(vm.time)")
                .font(.system(size: 100))
                .alert("Good job!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        vm.finished = true
                        vm.selectedValue = modelData.progress[0].elapsed.count - 1
                    }
                }
                .animation(nil, value: 0)

                
//            //DEBUG
            if vm.debug {
                Text("chosen index: \(vm.chosenIndex)")
                Text("sec: \(vm.seconds)")
                Text("lastAdded: \(vm.lastAddedCount)")
                Text("count: \(modelData.progress[0].elapsed.count)")
            }

            // Start/Pause buttons
            HStack {
                Button("Pause", role: .destructive) {
                    vm.pause()
                }
                .disabled(!vm.isActive)
                
                Spacer()
                    .frame(width: 200)
                
                Button("Start") {
                    vm.start(sec: vm.seconds)
                }
                .disabled(vm.isActive || vm.finished || vm.showingAlert)
            }
            .padding(.horizontal)
            .padding(.top, -30)
            .padding(.bottom, 10)
            .buttonStyle(.borderedProminent)
            
            Group {
                Text("\(modelData.quotes[randomInt].text)")
                Text("- \(modelData.quotes[randomInt].author ?? "Anonymous")")
            }
            .padding(.horizontal)
            .animation(.easeIn, value: modelData.quotes[randomInt])
            
            // Progress visual
            ProgressLine(selectedValue: $vm.selectedValue)
                .padding(25)
        }
        .onReceive(timer) { _ in
            vm.updateCountDown()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
