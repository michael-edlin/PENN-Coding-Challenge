//
//  AQIData.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/21/24.
//

import Foundation

struct AQIData: Decodable {
    let status: String
    let data: AQIDataDetails?
    let error: String?
}
