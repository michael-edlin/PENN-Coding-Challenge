//
//  AQIData.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/21/24.
//

import Foundation

struct AQIData: Decodable {
    let city: String
    let aqi: Int
    let details: AQIDataDetails
}
