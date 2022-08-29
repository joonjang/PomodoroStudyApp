//
//  LineChartView.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-28.
//

import SwiftUI

 struct LineChartView: View {
    var values: [Int]
    var labels: [Int]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        
        if values.isEmpty {
            return Path()
        }
        
        var offsetX: Int = -Int(screenWidth/CGFloat(values.count))/2
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: values[0]))
        
        for value in values {
            offsetX += Int(screenWidth/CGFloat(values.count))
            path.addLine(to: CGPoint(x: offsetX, y: value*100))
        }
        return path
        
    }
    
    var body: some View {
        VStack {
            path.stroke(Color.red, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y:1, z: 0))
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            
            HStack {
                ForEach(labels, id: \.self) { label in
                    Text("\(label)")
                        .frame(width: screenWidth/CGFloat(labels.count) - 10)
                }
            }
            
        }
    }
}
