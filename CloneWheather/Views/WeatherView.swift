//
//  WeatherView.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 17.11.2024.
//

import SwiftUI

struct WeatherView: View {
    private let apiKey: String?
    @StateObject private var weatherViewModel: WeatherViewModel

    init(apiKey: String?) {
        self.apiKey = apiKey
        _weatherViewModel = StateObject(wrappedValue: WeatherViewModel(apiKey: apiKey))
    }

    var body: some View {
        ScrollView {
            VStack {
                WeatherSummaryView(apiKey: apiKey)
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                HourlyForecastView(lat: 44.4268, lon: 26.1025, weatherService: WeatherService(apiKey: self.apiKey))
                DailyForecastView(apiKey: apiKey)
                AirQualityView(apiKey: apiKey)
                HStack {
                    UVIndexView(apiKey: apiKey)
                        .aspectRatio(1.0, contentMode: .fill)
                    SunTrackerView()
                        .aspectRatio(1.0, contentMode: .fill)
                }
            }
            .padding(.horizontal)
        }
        .background(.blue)
        .onAppear {
            weatherViewModel.fetchWeather(for: "Constanta")
        }
    }
}

#Preview {
    WeatherView(apiKey: SecretsHelper.value(forKey: SecretsHelper.Keys.API_KEY))
}
