//
//  HourlyForecastResponse.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 02.12.2024.
//


struct HourlyForecastResponse: Codable {
    let hourly: [HourlyData]
    
    struct HourlyData: Codable {
        let dt: Int 
        let temp: Double
        let weather: [Weather]
    }
    
    struct Weather: Codable {
        let id: Int
    }
}
