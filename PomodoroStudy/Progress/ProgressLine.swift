//
//  ProgressLine.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-27.
//

import SwiftUI

struct ProgressLine: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var selectedValue: Int?

    var body: some View {
        let data = modelData.progress[0].elapsed

//        //https://developer.apple.com/documentation/swift/array/map(_:)-87c4d
//        let time = data.map { $0.time }
//        let height = data.map { $0.height }
        VStack {
            LineGraphView(values: data, selectedValue: $selectedValue)
                .frame(maxHeight: .infinity)
            Text("(Minutes Of Climbing To Success)")
        }
    }

}

struct ProgressLine_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLine(selectedValue: .constant(0))
            .environmentObject(ModelData())
    }
}
