//
//  NetworkManager.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/21/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://api.waqi.info/feed/geo:"
    private var token = "aa0f619b56abed29175510b2e3f689917d194eab"

    enum NetworkError: Error {
        case badURL
        case requestFailed
        case decodingError(Error)
        case unknown
    }

    func fetchAQIData(for latitude: Double, longitude: Double) async throws -> AQIData {
        let urlString = "\(baseURL)\(latitude);\(longitude)/?token=\(token)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.requestFailed
            }
            guard httpResponse.statusCode == 200 else {
                print("HTTP Error: \(httpResponse.statusCode)")
                throw NetworkError.requestFailed
            }

            // Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }

            let decoder = JSONDecoder()
            do {
                let aqiData = try decoder.decode(AQIData.self, from: data)
                return aqiData
            } catch {
                print("Decoding Error: \(error)")
                throw NetworkError.decodingError(error)
            }
        } catch {
            print("Network Error: \(error)")
            throw NetworkError.unknown
        }
    }
}
