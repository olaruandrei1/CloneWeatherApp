//
//  WeatherCondition.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import Foundation
import SwiftUI

enum WeatherCondition {
    case sunny
    case cloudy
    case rainy
    case snowy
    case thunderstorm
    case clear
    case unknown

    static func from(weatherId: Int) -> WeatherCondition {
        switch weatherId {
        case 200...232:
            return .thunderstorm
        case 300...321, 500...531:
            return .rainy
        case 600...622:
            return .snowy
        case 701...781:
            return .cloudy
        case 800:
            return .clear
        case 801...804:
            return .cloudy
        default:
            return .unknown
        }
    }

    var image: Image {
        switch self {
        case .sunny, .clear:
            return Image(systemName: "sun.max.fill")
        case .cloudy:
            return Image(systemName: "cloud.fill")
        case .rainy:
            return Image(systemName: "cloud.rain.fill")
        case .snowy:
            return Image(systemName: "snow")
        case .thunderstorm:
            return Image(systemName: "cloud.bolt.fill")
        case .unknown:
            return Image(systemName: "questionmark.circle.fill")
        }
    }
}
