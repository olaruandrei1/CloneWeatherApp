import Foundation

class WeatherService {
    private let apiService: APIService
    private let baseURLWeather: String
    private let baseURLWeatherOneCall: String
    private let baseURLAirPollution: String
    private let baseURLUV: String

    init(apiKey: String?) {
        self.apiService = APIService(apiKey: apiKey)
        self.baseURLWeather = "https://api.openweathermap.org/data/2.5"
        self.baseURLWeatherOneCall = "https://api.openweathermap.org/data/2.5"
        self.baseURLAirPollution = "https://api.openweathermap.org/data/2.5"
        self.baseURLUV = "https://api.openweathermap.org/data/2.5"
    }
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        apiService.fetchData(
            baseURL: baseURLWeather,
            endpoint: "/weather",
            queryParameters: [
                "q": city,
                "units": "metric"
            ],
            responseType: WeatherResponse.self,
            completion: completion
        )
    }

    func fetchMoreDaysForecast(lat: Double, lon: Double, completion: @escaping (Result<[DailyForecast], Error>) -> Void) {
        apiService.fetchData(
            baseURL: baseURLWeatherOneCall,
            endpoint: "/onecall",
            queryParameters: [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "exclude": "current,minutely,hourly,alerts",
                "units": "metric"
            ],
            responseType: DailyForecastMap.self
        ) { result in
            switch result {
            case .success(let dailyForecastMap):
                completion(.success(dailyForecastMap.daily))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchAirPollution(lat: Double, lon: Double, completion: @escaping (Result<AirPollutionResponse, Error>) -> Void) {
        apiService.fetchData(
            baseURL: baseURLAirPollution,
            endpoint: "/air_pollution",
            queryParameters: [
                "lat": "\(lat)",
                "lon": "\(lon)"
            ],
            responseType: AirPollutionResponse.self,
            completion: completion
        )
    }

    func fetchUVIndex(lat: Double, lon: Double, completion: @escaping (Result<UVIndexResponse, Error>) -> Void) {
        apiService.fetchData(
            baseURL: baseURLUV,
            endpoint: "/uvi",
            queryParameters: [
                "lat": "\(lat)",
                "lon": "\(lon)"
            ],
            responseType: UVIndexResponse.self,
            completion: completion
        )
    }
    
    func fetchHourlyForecast(lat: Double, lon: Double, completion: @escaping (Result<[WeatherSnapshot], Error>) -> Void) {
        apiService.fetchData(
            baseURL: baseURLWeatherOneCall,
            endpoint: "/onecall",
            queryParameters: [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "exclude": "current,minutely,daily,alerts",
                "units": "metric"
            ],
            responseType: HourlyForecastResponse.self
        ) { result in
            switch result {
            case .success(let response):
                let snapshots = response.hourly.map { hourlyData in
                    WeatherSnapshot(
                        time: Date(timeIntervalSince1970: TimeInterval(hourlyData.dt)),
                        condition: WeatherCondition.from(weatherId: Int(hourlyData.weather.first?.id ?? 0)),
                        temperature: .C(Int(hourlyData.temp))
                    )
                }

                completion(.success(snapshots))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
