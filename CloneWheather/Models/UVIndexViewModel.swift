//
//  AirPollutionResponse.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation
class UVIndexViewModel: ObservableObject {
    @Published var uvIndex: UVIndexData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherService
    
    init(apiKey: String?) {
        self.weatherService = WeatherService(apiKey: apiKey)
    }

    func fetchUVIndex(latitude: Double = 44.1833, longitude: Double = 28.65) {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchUVIndex(lat: latitude, lon: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    let uvData = response.value // Direct assignment since it's non-optional
                    self?.uvIndex = UVIndexData(index: uvData,
                                                 category: self?.mapUVCategory(uvIndex: uvData) ?? "Unknown",
                                                 normalizedIndex: uvData / 11.0)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func mapUVCategory(uvIndex: Double) -> String {
        switch uvIndex {
        case 0...2:
            return "Low"
        case 3...5:
            return "Moderate"
        case 6...7:
            return "High"
        case 8...10:
            return "Very High"
        default:
            return "Extreme"
        }
    }

    var uvCategory: String {
        uvIndex?.category ?? "Unknown"
    }

    var sunProtectionAdvice: String {
        switch uvIndex?.index ?? 0 {
        case 0...2:
            return "No protection needed"
        case 3...5:
            return "Wear sunscreen"
        case 6...7:
            return "Wear sunscreen, protective clothing"
        case 8...10:
            return "Wear sunscreen, protective clothing, and avoid midday sun"
        default:
            return "Extreme caution, stay indoors"
        }
    }
}

struct UVIndexData {
    let index: Double
    let category: String
    let normalizedIndex: Double
}
