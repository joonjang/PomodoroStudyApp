//
//  QuotesModel.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-09-16.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quotes = try? newJSONDecoder().decode(Quotes.self, from: jsonData)

import Foundation

// MARK: - Quote
struct QuotesModel : Codable, Hashable {
    var text: String
    var author: String?
}
