//
//  DailyForecastView.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 17.11.2024.
//

import SwiftUI

struct DailyForecastView: View {
    @StateObject var viewModel: DailyForecastViewModel

    init(apiKey: String?) {
        _viewModel = StateObject(wrappedValue: DailyForecastViewModel(apiKey: apiKey))
    }

    var body: some View {
        VStack(alignment: .leading) {
            (
                Text(Image(systemName: "calendar"))
                +
                Text("7-Day Forecast".uppercased())
            )
            .font(Font.system(size: 12))
            .fontWeight(.medium)
            .foregroundColor(Color.currentTheme.sectionHeaderColor)
            Divider()

            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ForEach(viewModel.forecast, id: \.dt) { day in
                    HStack {
                        Text(viewModel.formatDate(day.dt))
                            .font(Font.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                        Image(systemName: "cloud.fill")
                            .foregroundColor(.yellow)

                        Spacer()
                            .frame(maxWidth: 50.0)

                        Text("\(Int(day.temp.min))°")
                            .foregroundColor(Color.white.opacity(0.6))

                        ProgressView(value: 0.5)
                            .progressViewStyle(ProgressViewComponentView(
                                range: 0.2...0.8,
                                foregroundColor: AnyShapeStyle(viewModel.progressGradientColors),
                                backgroundColor: Color(red: 0.25, green: 0.35, blue: 0.72).opacity(0.2)
                            ))
                            .frame(maxWidth: 100, maxHeight: 4.0)

                        Text("\(Int(day.temp.max))°")
                            .foregroundColor(.white)
                    }
                    Divider()
                }
            }
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        .onAppear {
            viewModel.fetchForecast()
        }
    }
}
