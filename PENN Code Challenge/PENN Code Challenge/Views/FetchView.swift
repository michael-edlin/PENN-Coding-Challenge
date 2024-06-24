//
//  FetchView.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/24/24.
//

import SwiftUI
import FirebaseAuth

struct FetchView: View {
    @State private var selectedCityIndex: Int = 0
    var cities: [MajorCity]
    var onCitySelected: (MajorCity) -> Void
    weak var delegate: FetchViewDelegate?
    
    var cornerRadius: CGFloat = 25
    
    var body: some View {
        VStack {
            locationPicker
            Spacer()
            signOutButton
        }
    }
    
    private var locationPicker: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "location.magnifyingglass")
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color.accent)
                    .mask(Circle())
                    .shadow(radius: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Picker("Select for another city's AQI value", selection: $selectedCityIndex) {
                        ForEach(0..<cities.count, id: \.self) { index in
                            Text(self.cities[index].name).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedCityIndex) { index in
                        self.onCitySelected(cities[index])
                    }
                }
                Spacer()
            }
            .padding(4)
        }
        .background(
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.white, .white]), center: .topLeading, startRadius: 5, endRadius: 500)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    private var signOutButton: some View {
        Button(action: signOut) {
            Text("Sign Out")
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut()
            print("Signed out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    FetchView(cities: [
        MajorCity(name: "San Francisco", latitude: 37.7749, longitude: -122.4194),
        MajorCity(name: "New York", latitude: 40.7128, longitude: -74.0060),
        MajorCity(name: "Los Angeles", latitude: 34.0522, longitude: -118.2437)
    ]) { _ in }
}
