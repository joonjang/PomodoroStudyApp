//
//  ProgressLine.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-27.
//

import SwiftUI

struct ProgressLine: View {
    var progress: ProgressModel
    
    var body: some View {
        let data = progress.elapsed

        //https://developer.apple.com/documentation/swift/array/map(_:)-87c4d
        let time = data.map { $0.time }
        let height = data.map { $0.height }
        
        
        VStack {
            Text("Progress")
                .font(.largeTitle)

            LineChartView(values: height, labels: time)
            
            // DEBUGGING SHOW JSON
            List {
                    VStack {
                        
                        ForEach(height, id: \.self) { item in
                            Text("\(item)")
                        }
//                        Text("Time \(time)")
//                        Text("Height \(height)"
                        
//                        ForEach(data, id: \.self) { item in
//                            Text("Time \(item.time)")
//                            Text("Height \(item.height)")
//                        }
                }
                
                Text("TEST \(data[1])" as String)
            }
        }
        
        
        
    }
}

struct ProgressLine_Previews: PreviewProvider {
    static var progress = ModelData().progress[0]
    
    static var previews: some View {
        ProgressLine(progress: progress)
    }
}
