//
//  ActiveProgression.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-29.
//

import SwiftUI

struct ActiveProgression: View {
    var climbing: Bool
    var chosenTime: Float
    var currentSec: Float
    
    var body: some View {
        // Progress visual
        VStack {
            if(climbing) {
                ProgressView(value: chosenTime - currentSec, total: chosenTime)
                    .rotationEffect(.degrees(-45))
                    .offset(x:-24)
            } else {
                ProgressView(value: chosenTime - currentSec, total: chosenTime)
                    .offset(x: -10 ,y: 34)
            }

        }
    }
}

struct ActiveProgression_Previews: PreviewProvider {
    static var previews: some View {
        ActiveProgression(climbing: false, chosenTime: 10.0, currentSec: 4.0)
    }
}
