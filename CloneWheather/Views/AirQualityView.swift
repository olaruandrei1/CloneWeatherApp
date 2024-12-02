//
//  AirQualityView.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import SwiftUI

struct AirQualityView: View {
    @StateObject private var viewModel: AirQualityViewModel

    init(apiKey: String?) {
        _viewModel = StateObject(wrappedValue: AirQualityViewModel(apiKey: apiKey))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            (
                Text(Image(systemName: "aqi.low"))
                +
                Text("Air Quality".uppercased())
            )
            .foregroundStyle(Color.currentTheme.sectionHeaderColor)
            .font(Font.system(size: 12))
            .fontWeight(.medium)
            .shadow(color: .gray.opacity(0.2), radius: 1.0)
            .padding(.bottom, 10)

            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let airQuality = viewModel.airQuality {
                Text("\(airQuality.index) - \(airQuality.category)")
                    .foregroundStyle(.white)
                    .font(Font.system(size: 24))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text(airQuality.description)
                    .foregroundStyle(.white)
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .padding(.bottom, 32)
                ProgressView(value: airQuality.normalizedIndex)
                    .progressViewStyle(ProgressViewComponentView(range: 0...1.0, foregroundColor: AnyShapeStyle(uvGradient), backgroundColor: .gray))
                    .frame(maxHeight: 5.0)
                    .padding(.bottom, 14)
            } else {
                Text("No air quality data available.")
                    .foregroundStyle(.white)
            }
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        .onAppear {
            viewModel.fetchAirQuality()
        }
    }

    var uvGradient: LinearGradient {
        return LinearGradient(colors:
                                [
                                    .green,
                                    .yellow,
                                    .orange,
                                    .red,
                                    .purple
                                ], startPoint: .leading, endPoint: .trailing)
    }
}

#Preview {
    VStack {
        AirQualityView(apiKey: SecretsHelper.Keys.API_KEY.rawValue)
            .padding()
        Spacer()
    }
    .background(.blue)
}
