import SwiftUI

struct HourlyForecastView: View {
    @StateObject private var viewModel: ViewModel

    init(lat: Double, lon: Double, weatherService: WeatherService) {
        _viewModel = StateObject(wrappedValue: ViewModel(lat: lat, lon: lon, weatherService: weatherService))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.currentWeatherSummary)
                .font(Font.system(size: 12))
                .fontWeight(.medium)
                .shadow(radius: 2.0)
                .foregroundStyle(.white)
                .padding(.bottom, 6)
            Divider()
                .padding(.bottom, 8)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.weatherSnapshots, id: \.time) { snapshot in
                        VStack {
                            Text(snapshot.time, style: .time)
                                .font(Font.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            snapshot.condition.image
                                .padding(.vertical, 4)
                            Text(snapshot.temperature.celciusString)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .font(Font.system(size: 20))
                        }
                        .padding(.trailing, 18)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .padding(14)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        .onAppear {
            viewModel.fetchHourlyForecast()
        }
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(
            lat: 44.4268,
            lon: 26.1025,
            weatherService: WeatherService(apiKey: SecretsHelper.value(forKey: SecretsHelper.Keys.API_KEY))
        )
        .padding()
        .background(.blue)
    }
}

extension HourlyForecastView {
    class ViewModel: ObservableObject {
        @Published var currentWeatherSummary: String = "Loading..."
        @Published var weatherSnapshots: [WeatherSnapshot] = []
        
        private let lat: Double
        private let lon: Double
        private let weatherService: WeatherService

        init(lat: Double, lon: Double, weatherService: WeatherService) {
            self.lat = lat
            self.lon = lon
            self.weatherService = weatherService
        }

        func fetchHourlyForecast() {
            weatherService.fetchHourlyForecast(lat: lat, lon: lon) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let snapshots):
                        self?.currentWeatherSummary = "Today's hourly forecast."
                        self?.weatherSnapshots = snapshots
                    case .failure:
                        self?.currentWeatherSummary = "Failed to load forecast."
                    }
                }
            }
        }
    }
}
