//
//  DailyForecastViewModel.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation
import SwiftUI

class DailyForecastViewModel: ObservableObject {
    @Published var forecast: [DailyForecast] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherService
    
    init(apiKey: String?) {
        self.weatherService = WeatherService(apiKey: apiKey)
    }
    
    func fetchForecast() {
        isLoading = true
        errorMessage = nil
        
        // Mock coordinates for Constanta, Romania
        let latitude = 44.1833
        let longitude = 28.65
        
        weatherService.fetchMoreDaysForecast(lat: latitude, lon: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.forecast = data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func formatDate(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    var progressGradientColors: LinearGradient {
        LinearGradient(colors: [Color.blue, Color.orange], startPoint: .leading, endPoint: .trailing)
    }
}
