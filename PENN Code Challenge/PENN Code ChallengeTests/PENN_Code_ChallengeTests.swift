//
//  PENN_Code_ChallengeTests.swift
//  PENN Code ChallengeTests
//
//  Created by Tyler Edlin on 6/20/24.
//

import Testing
@testable import PENN_Code_Challenge
import XCTest

class NetworkManagerTests: XCTestCase {

    func testFetchAQIDataSuccess() async throws {
        // Given
        let latitude = 37.7749
        let longitude = -122.4194
        
        // When
        do {
            let aqiData = try await NetworkManager.shared.fetchAQIData(for: latitude, longitude: longitude)
            
            // Then
            XCTAssertNotNil(aqiData, "AQI data should not be nil")
            XCTAssertEqual(aqiData.status, "ok", "Status should be 'ok'")
        } catch {
            XCTFail("Failed to fetch AQI data: \(error)")
        }
    }
}
