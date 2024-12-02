//
//  WeatherViewModel.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 27.11.2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let weatherService: WeatherService

    init(apiKey: String?) {
        self.weatherService = WeatherService(apiKey: apiKey)
    }

    func fetchWeather(for city: String) {
        self.isLoading = true
        self.errorMessage = nil

        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.weatherResponse = response
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
