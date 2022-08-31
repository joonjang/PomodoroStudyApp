//
//  LineChartView.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-28.
//

import SwiftUI

 struct LineChartView: View {
     var height: [Int]
     var time: [Int]
     let xOffset = 10
     let xScale = 2

    private var path: Path {
        
        if height.isEmpty {
            return Path()
        }
        
        var path = Path()
        
        path.move(to: CGPoint(x: xOffset, y: 0))
        
        for (he, ti) in zip(height, time) {
            path.addLine(to: CGPoint(x: (ti + xOffset) * xScale, y: he * 50))
        }

        
        return path
        
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            path.stroke(Color.brown, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y:1, z: 0))
                .frame(maxWidth: .infinity, maxHeight: 300)
                .offset(y:-10)
            
            VStack(spacing: 15) {
                ForEach(time.reversed(), id: \.self) { ti in
                    Text("\(ti)")
                        .position(x: CGFloat((ti + xOffset) * xScale)  )
                        .frame(height: 1)
                        .font(.system(size:12))
                }
            }
            Text("(Minutes)")
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLine()
            .environmentObject(ModelData())
        ProgressLine()
            .environmentObject(ModelData())
    }
}
