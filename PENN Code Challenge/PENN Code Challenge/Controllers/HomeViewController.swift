//
//  HomeViewController.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/23/24.
//

import UIKit
import Combine
import SwiftUI
import CoreLocation

class HomeViewController: UIViewController, FetchViewDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var aqiValue: UILabel!
    @IBOutlet weak var aqiPriorValue: UILabel!
    @IBOutlet weak var aqiFutureValue: UILabel!
    @IBOutlet weak var coordinatesValue: UILabel!
    @IBOutlet weak var priorDateLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var futureDateLabel: UILabel!
    @IBOutlet weak var weatherStationLabel: UILabel!
    
    private var tokens: Set<AnyCancellable> = []
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func fetchData() {
        guard let location = currentLocation else {
            print("Location is not available yet.")
            return
        }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        Task {
            do {
                let aqiData = try await NetworkManager.shared.fetchAQIData(for: latitude, longitude: longitude)
                updateView(with: aqiData)
            } catch {
                print("Error fetching AQI data: \(error)")
            }
        }
    }
    
    private func fetchData(for latitude: Double, longitude: Double) {
        Task {
            do {
                print("Fetching AQI data for coordinates: \(latitude), \(longitude)")
                let aqiData = try await NetworkManager.shared.fetchAQIData(for: latitude, longitude: longitude)
                updateView(with: aqiData)
            } catch {
                print("Error fetching AQI data: \(error)")
            }
        }
    }
    
    private func updateView(with aqiData: AQIData) {
        DispatchQueue.main.async {
            guard let data = aqiData.data else {
                self.titleLabel.text = "No data available"
                return
            }
            self.titleLabel.text = data.city.name
            self.aqiValue.text = "\(data.aqi)"
            self.coordinatesValue.text = "\(data.city.geo[0]), \(data.city.geo[1])"
            
            
            self.weatherStationLabel.text = data.attributions.first?.name ?? "Unknown Station"
            
            if let forecast = data.forecast {
                self.updateForecastValues(forecast)
            }
        }
    }
    
    private func updateForecastValues(_ forecast: Forecast) {
        guard let pm25Forecast = forecast.daily.pm25 else { return }
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today)
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "MM/dd/yy"
        
        guard let todayIndex = pm25Forecast.firstIndex(where: { $0.day == todayString }) else { return }
        
        if todayIndex > 0 {
            let priorDay = pm25Forecast[todayIndex - 1]
            aqiPriorValue.text = "\(priorDay.avg)"
            if let priorDate = dateFormatter.date(from: priorDay.day) {
                priorDateLabel.text = displayDateFormatter.string(from: priorDate)
            }
        } else {
            aqiPriorValue.text = "N/A"
            priorDateLabel.text = "N/A"
        }
        
        aqiValue.text = "\(pm25Forecast[todayIndex].avg)"
        currentDateLabel.text = displayDateFormatter.string(from: today)
        
        if todayIndex < pm25Forecast.count - 1 {
            let futureDay = pm25Forecast[todayIndex + 1]
            aqiFutureValue.text = "\(futureDay.avg)"
            if let futureDate = dateFormatter.date(from: futureDay.day) {
                futureDateLabel.text = displayDateFormatter.string(from: futureDate)
            }
        } else {
            aqiFutureValue.text = "N/A"
            futureDateLabel.text = "N/A"
        }
    }
    
    private func updateLocationAndFetchData(for city: MajorCity) {
        if city.name == "Current Location" {
            fetchData()
        } else {
            fetchData(for: city.latitude, longitude: city.longitude)
            DispatchQueue.main.async {
                self.coordinatesValue.text = "\(city.latitude), \(city.longitude)"
                print("Updated coordinates value label: \(self.coordinatesValue.text ?? "")")
            }
        }
    }
    
    @IBSegueAction func createFetchView(_ coder: NSCoder) -> UIViewController? {
        let hostView = UIHostingController(coder: coder, rootView: FetchView(cities: [
            MajorCity(name: "Current Location", latitude: 0, longitude: 0),
            MajorCity(name: "San Francisco", latitude: 37.7749, longitude: -122.4194),
            MajorCity(name: "New York", latitude: 40.7128, longitude: -74.0060),
            MajorCity(name: "Los Angeles", latitude: 34.0522, longitude: -118.2437)
        ]) { selectedCity in
            self.updateLocationAndFetchData(for: selectedCity)
        })
        hostView?.rootView.delegate = self
        hostView?.view.backgroundColor = .clear
        return hostView
    }
    
    func didSignOut() {
        DispatchQueue.main.async {
            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        print("Location updated: \(latitude), \(longitude)")
        fetchData(for: latitude, longitude: longitude)
        DispatchQueue.main.async {
            self.coordinatesValue.text = "\(latitude), \(longitude)"
            print("Updated coordinates value label: \(self.coordinatesValue.text ?? "")")
        }
    }
}
