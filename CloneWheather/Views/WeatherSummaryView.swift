//
//  WeatherSummaryView.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 17.11.2024.
//

import SwiftUI

struct WeatherSummaryView: View {
    @StateObject var weatherViewModel: WeatherViewModel

    init(apiKey: String?) {
        _weatherViewModel = StateObject(wrappedValue: WeatherViewModel(apiKey: apiKey))
    }

    var body: some View {
        VStack {
            if let weather = weatherViewModel.weatherResponse {
                VStack {
                    Text(weather.name)
                        .font(Font.system(size: 32))
                        .foregroundStyle(.white)
                        .shadow(radius: 2.0)

                    Text("\(weather.main.temp.formattedTemperature())°C")
                        .font(Font.system(size: 100))
                        .fontWeight(.thin)
                        .foregroundStyle(.white)
                        .shadow(radius: 2.0)

                    Text("Feels like: \(weather.main.feels_like.formattedTemperature())°C")
                        .font(Font.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .shadow(radius: 2.0)

                    Text("Max: \(weather.main.temp_max.formattedTemperature())°C Min: \(weather.main.temp_min.formattedTemperature())°C")
                        .font(Font.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .shadow(radius: 2.0)
                }
            } else if weatherViewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = weatherViewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("No weather data available.")
            }
        }
        .onAppear {
            weatherViewModel.fetchWeather(for: "Constanta")
        }
    }
}

#Preview {
    ScrollView {
        HStack {
            Spacer()
            WeatherSummaryView(apiKey: SecretsHelper.value(forKey:  SecretsHelper.Keys.API_KEY))
            Spacer()
        }.padding(.top, 70)
    }.background(.blue)
}
