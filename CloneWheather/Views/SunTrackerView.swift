import SwiftUI

struct SunTrackerView: View {
    @State private var sunsetTime: String = "Loading..."
    @State private var sunriseTime: String = "Loading..."
    @State private var errorMessage: String? = nil
    private let weatherService = WeatherService(apiKey: SecretsHelper.value(forKey:  SecretsHelper.Keys.API_KEY))

    var body: some View {
        VStack(alignment: .leading) {
            (
                Text(Image(systemName: "sunset.fill"))
                +
                Text("Sunset".uppercased())
            )
            .font(Font.system(size: 12))
            .fontWeight(.medium)
            .foregroundColor(Color.currentTheme.sectionHeaderColor)
            .shadow(radius: 1.0)

            Text(sunsetTime)
                .font(Font.system(size: 36))
                .fontWeight(.regular)
                .foregroundColor(.white)
                .shadow(radius: 1.0)

            Spacer()

            ZStack {
                GeometryReader { geometry in
                    SunWaveView(
                        dayColor: Color(red: 0.63, green: 0.72, blue: 0.87),
                        nightColor: Color(red: 0.28, green: 0.45, blue: 0.63),
                        sunColor: Color.white,
                        horizonColor: Color(red: 0.69, green: 0.78, blue: 0.88),
                        sunPosition: 0.75
                    )
                    .frame(height: geometry.size.width / 2)
                }
            }

            Spacer()

            Text("Sunrise: \(sunriseTime)")
                .font(Font.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .shadow(radius: 1.0)

            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding(10.0)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        .onAppear {
            fetchWeatherData()
        }
    }

    private func fetchWeatherData() {
        weatherService.fetchWeather(for: "London") { result in
            switch result {
            case .success(let weatherResponse):
                // Access sys directly, as sys is non-optional and both sunset and sunrise are Int
                let sys = weatherResponse.sys
                self.sunsetTime = formatTime(timestamp: sys.sunset)
                self.sunriseTime = formatTime(timestamp: sys.sunrise)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func formatTime(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    ScrollView {
        HStack {
            SunTrackerView()
                .aspectRatio(1.0, contentMode: .fill)
            SunTrackerView()
        }
    }
    .padding()
    .background(.blue)
}
