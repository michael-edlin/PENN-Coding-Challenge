//
//  AQIDataDetails.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/21/24.
//

import Foundation

struct AQIDataDetails: Codable {
    let city: City
    let aqi: Int
    let time: Time
    let forecast: Forecast?
}

// MARK: - City
struct City: Codable {
    let name: String
    let geo: [Double]
}

// MARK: - Time
struct Time: Codable {
    let s: String
    let tz: String
    let v: Int
}

// MARK: - Forecast
struct Forecast: Codable {
    let daily: [DailyForecast]
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let avg: Int
    let day: String
    let max: Int
    let min: Int
}
