//
//  APIService.swift
//  CloneWeather
//
//  Created by Andrei Olaru on 25.11.2024.
//

import Foundation

class APIService {
    private let apiKey: String?
    
    init(apiKey: String?) {
        self.apiKey = apiKey
    }
    
    func fetchData<T: Decodable>(baseURL: String, endpoint: String, queryParameters: [String: String] = [:], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let apiKey = apiKey else {
            completion(.failure(WeatherErrorHandler.missingAPIKey))
            return
        }
        
        var urlComponents = URLComponents(string: baseURL + endpoint)
        var queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems.append(URLQueryItem(name: "appid", value: apiKey))
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(.failure(WeatherErrorHandler.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(WeatherErrorHandler.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON: \(jsonString)")
                }
                completion(.failure(WeatherErrorHandler.decodingError))
            }
        }
        
        task.resume()
    }
}
