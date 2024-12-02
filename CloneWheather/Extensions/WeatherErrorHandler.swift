//
//  WeatherErrorHandler.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 25.11.2024.
//

import Foundation

enum WeatherErrorHandler: Error, LocalizedError {
    case missingAPIKey, missingBaseUrl, invalidURL, noData, decodingError

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "Application failed"
        case .missingBaseUrl:
            return "Weather data are unavailable"
        case .invalidURL:
            return "Sometimes, people change their code, not just the personality!"
        case .noData:
            return "Sometimes, people make promises like : 'I will get back', in this case : there is no data."
        case .decodingError:
            return "My bad here"
        }
    }
}
