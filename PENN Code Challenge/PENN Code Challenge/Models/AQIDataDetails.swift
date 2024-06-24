//
//  AQIDataDetails.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/23/24.
//

import Foundation

struct AQIDataDetails: Codable {
    let aqi: Int
    let idx: Int
    let attributions: [Attribution]
    let city: City
    let dominentpol: String
    let iaqi: Iaqi?
    let time: Time
    let forecast: Forecast?
}

// MARK: - Attribution
struct Attribution: Codable {
    let url: String
    let name: String
    let logo: String?
}

// MARK: - City
struct City: Codable {
    let name: String
    let url: String
    let geo: [Double]
}

// MARK: - Iaqi
struct Iaqi: Codable {
    let co: IaqiValue?
    let h: IaqiValue?
    let no2: IaqiValue?
    let o3: IaqiValue?
    let p: IaqiValue?
    let pm10: IaqiValue?
    let pm25: IaqiValue?
    let t: IaqiValue?
    let w: IaqiValue?
    let wg: IaqiValue?
}

// MARK: - IaqiValue
struct IaqiValue: Codable {
    let v: Double
}

// MARK: - Time
struct Time: Codable {
    let s: String
    let tz: String
    let v: Int
    let iso: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let daily: DailyForecast
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let o3: [PollutantForecast]?
    let pm10: [PollutantForecast]?
    let pm25: [PollutantForecast]?
}

// MARK: - PollutantForecast
struct PollutantForecast: Codable {
    let avg: Int
    let day: String
    let max: Int
    let min: Int
}

