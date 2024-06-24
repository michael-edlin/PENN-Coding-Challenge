//
//  ViewController.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let cityLabel = UILabel()
    private let aqiLabel = UILabel()
    private let dominantPollutantLabel = UILabel()
    private let lastUpdatedLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "AQI Fetcher"
        
        setupLabels()
        fetchData()
    }
    
    private func setupLabels() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        aqiLabel.translatesAutoresizingMaskIntoConstraints = false
        dominantPollutantLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cityLabel)
        view.addSubview(aqiLabel)
        view.addSubview(dominantPollutantLabel)
        view.addSubview(lastUpdatedLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            aqiLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            aqiLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aqiLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dominantPollutantLabel.topAnchor.constraint(equalTo: aqiLabel.bottomAnchor, constant: 20),
            dominantPollutantLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dominantPollutantLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastUpdatedLabel.topAnchor.constraint(equalTo: dominantPollutantLabel.bottomAnchor, constant: 20),
            lastUpdatedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func fetchData() {
        Task {
            do {
                let aqiData = try await NetworkManager.shared.fetchAQIData(for: 37.7749, longitude: -122.4194)
                updateView(with: aqiData)
            } catch {
                print("Error fetching AQI data: \(error)")
            }
        }
    }
    
    private func updateView(with aqiData: AQIData) {
        DispatchQueue.main.async {
            guard let data = aqiData.data else {
                self.cityLabel.text = "No data available"
                return
            }
            
            self.cityLabel.text = "City: \(data.city.name)"
            self.aqiLabel.text = "AQI: \(data.aqi)"
            self.dominantPollutantLabel.text = "Dominant Pollutant: \(data.dominentpol)"
            self.lastUpdatedLabel.text = "Last Updated: \(data.time.s)"
        }
    }
}
