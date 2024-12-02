//
//  AirQualityViewModel.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import Foundation

class AirQualityViewModel: ObservableObject {
    @Published var airQuality: AirQualityData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherService

    init(apiKey: String?) {
        self.weatherService = WeatherService(apiKey: apiKey)
    }

    func fetchAirQuality(latitude: Double = 44.1833, longitude: Double = 28.65) {
        isLoading = true
        errorMessage = nil

        weatherService.fetchAirPollution(lat: latitude, lon: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    if let airPollution = response.list.first {
                        self?.airQuality = AirQualityData(
                            index: airPollution.main.aqi,
                            category: (self?.mapAirQualityCategory(aqi: airPollution.main.aqi))!,
                            description: "Air quality index is \(airPollution.main.aqi), " +
                                         "\(self?.mapAirQualityCategory(aqi: airPollution.main.aqi) ?? "")",
                            normalizedIndex: Double(airPollution.main.aqi) / 5.0
                        )
                    } else {
                        self?.errorMessage = "No air quality data available."
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func mapAirQualityCategory(aqi: Int) -> String {
        switch aqi {
        case 1: return "Good"
        case 2: return "Fair"
        case 3: return "Moderate"
        case 4: return "Poor"
        case 5: return "Very Poor"
        default: return "Unknown"
        }
    }
}

struct AirQualityData {
    let index: Int
    let category: String
    let description: String
    let normalizedIndex: Double
}
