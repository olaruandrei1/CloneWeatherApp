//
//  DailyForecastModel.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation

struct DailyForecastMap: Codable {
    let daily: [DailyForecast]
}

struct DailyForecast: Codable {
    let dt: TimeInterval
    let temp: Temperature
    
    struct Temperature: Codable {
        let day: Double
        let min: Double
        let max: Double
    }
}
