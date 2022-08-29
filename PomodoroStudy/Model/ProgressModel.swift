//
//  ProgressModel.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-08-27.
//

import Foundation

struct ProgressModel: Codable, Hashable, Identifiable {
    // Date: https://developer.apple.com/documentation/foundation/dateformatter
    var id: String
    var elapsed: [Observation]

    struct Observation: Codable, Hashable {
        var time: Int
        var height: Int
    }
}
