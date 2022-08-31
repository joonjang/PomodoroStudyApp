//
//  ProgressLine.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-27.
//

import SwiftUI

struct ProgressLine: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        let data = modelData.progress[0].elapsed

        //https://developer.apple.com/documentation/swift/array/map(_:)-87c4d
        let time = data.map { $0.time }
        let height = data.map { $0.height }
        
        VStack {
            LineChartView(height: height, time: time)
        }
    }

}

struct ProgressLine_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLine()
            .environmentObject(ModelData())
    }
}
