//import UIKit
//import CoreLocation
//
//class ViewController: UIViewController {
//
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//    private let locationManager = CLLocationManager()
//
//    private let cityLabel = UILabel()
//    private let stackView = UIStackView()
//    private let fetchButton = UIButton(type: .system)
//    private let refreshButton = UIButton(type: .system)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = UIColor(red: 0.18, green: 0.31, blue: 0.53, alpha: 1.00) // light blue background
//        title = "AQI Fetcher"
//
//        setupScrollView()
//        setupContentView()
//        setupCityLabel()
//        setupStackView()
//        setupButtons()
//
//        setupLocationManager()
//        fetchData()
//    }
//
//    private func setupScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func setupContentView() {
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(contentView)
//
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
//    }
//
//    private func setupCityLabel() {
//        cityLabel.translatesAutoresizingMaskIntoConstraints = false
//        cityLabel.textAlignment = .center
//        cityLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
//        cityLabel.textColor = .white
//        contentView.addSubview(cityLabel)
//
//        NSLayoutConstraint.activate([
//            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
//        ])
//    }
//
//    private func setupStackView() {
//        stackView.axis = .vertical
//        stackView.spacing = 20 // increased spacing
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
//
//    private func setupButtons() {
//        fetchButton.translatesAutoresizingMaskIntoConstraints = false
//        refreshButton.translatesAutoresizingMaskIntoConstraints = false
//
//        fetchButton.setTitle("Fetch AQI Data", for: .normal)
//        fetchButton.backgroundColor = .systemBlue
//        fetchButton.setTitleColor(.white, for: .normal)
//        fetchButton.layer.cornerRadius = 10
//        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
//
//        let refreshIcon = UIImage(systemName: "arrow.clockwise")
//        refreshButton.setImage(refreshIcon, for: .normal)
//        refreshButton.tintColor = .white
//        refreshButton.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
//        refreshButton.layer.cornerRadius = 20
//        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
//
//        contentView.addSubview(fetchButton)
//        view.addSubview(refreshButton) // refreshButton is added to view, not contentView
//
//        NSLayoutConstraint.activate([
//            fetchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
//            fetchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            fetchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            fetchButton.heightAnchor.constraint(equalToConstant: 50),
//
//            refreshButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            refreshButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            refreshButton.widthAnchor.constraint(equalToConstant: 40),
//            refreshButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//
//    @objc private func fetchButtonTapped() {
//        fetchData()
//    }
//
//    @objc private func refreshButtonTapped() {
//        fetchData()
//    }
//
//    private func fetchData() {
//        Task {
//            do {
//                let aqiData = try await NetworkManager.shared.fetchAQIData(for: 37.7749, longitude: -122.4194)
//                updateView(with: aqiData)
//            } catch {
//                print("Error fetching AQI data: \(error)")
//            }
//        }
//    }
//
//    private func updateView(with aqiData: AQIData) {
//        DispatchQueue.main.async {
//            guard let data = aqiData.data else {
//                self.cityLabel.text = "No data available"
//                return
//            }
//
//            self.cityLabel.text = data.city.name
//            self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//
//            let aqiView = InfoView()
//            aqiView.configure(title: "AQI", value: "\(data.aqi)", advice: "Air Quality Index")
//            self.stackView.addArrangedSubview(aqiView)
//
//            let dominantPollutantView = InfoView()
//            dominantPollutantView.configure(title: "Dominant Pollutant", value: data.dominentpol, advice: "Main Pollutant")
//            self.stackView.addArrangedSubview(dominantPollutantView)
//
//            let lastUpdatedView = InfoView()
//            lastUpdatedView.configure(title: "Last Updated", value: data.time.s, advice: "Data refreshed")
//            self.stackView.addArrangedSubview(lastUpdatedView)
//
//            if let iaqi = data.iaqi {
//                if let co = iaqi.co {
//                    let coView = InfoView()
//                    coView.configure(title: "CO", value: "\(co.v)", advice: "Carbon Monoxide Level")
//                    self.stackView.addArrangedSubview(coView)
//                }
//
//                if let h = iaqi.h {
//                    let hView = InfoView()
//                    hView.configure(title: "Humidity", value: "\(h.v)", advice: "Humidity Level")
//                    self.stackView.addArrangedSubview(hView)
//                }
//
//                if let no2 = iaqi.no2 {
//                    let no2View = InfoView()
//                    no2View.configure(title: "NO2", value: "\(no2.v)", advice: "Nitrogen Dioxide Level")
//                    self.stackView.addArrangedSubview(no2View)
//                }
//
//                if let o3 = iaqi.o3 {
//                    let o3View = InfoView()
//                    o3View.configure(title: "O3", value: "\(o3.v)", advice: "Ozone Level")
//                    self.stackView.addArrangedSubview(o3View)
//                }
//
//                if let p = iaqi.p {
//                    let pView = InfoView()
//                    pView.configure(title: "Pressure", value: "\(p.v)", advice: "Pressure Level")
//                    self.stackView.addArrangedSubview(pView)
//                }
//
//                if let pm25 = iaqi.pm25 {
//                    let pm25View = InfoView()
//                    pm25View.configure(title: "PM2.5", value: "\(pm25.v)", advice: "Particulate Matter 2.5 Level")
//                    self.stackView.addArrangedSubview(pm25View)
//                }
//
//                if let t = iaqi.t {
//                    let tView = InfoView()
//                    tView.configure(title: "Temperature", value: "\(t.v)", advice: "Temperature Level")
//                    self.stackView.addArrangedSubview(tView)
//                }
//
//                if let w = iaqi.w {
//                    let wView = InfoView()
//                    wView.configure(title: "Wind Speed", value: "\(w.v)", advice: "Wind Speed")
//                    self.stackView.addArrangedSubview(wView)
//                }
//            }
//        }
//    }
//
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//}
//
//extension ViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        fetchData(for: location.coordinate.latitude, longitude: location.coordinate.longitude)
//    }
//
//    private func fetchData(for latitude: Double, longitude: Double) {
//        Task {
//            do {
//                let aqiData = try await NetworkManager.shared.fetchAQIData(for: latitude, longitude: longitude)
//                updateView(with: aqiData)
//            } catch {
//                print("Error fetching AQI data: \(error)")
//            }
//        }
//    }
//}
