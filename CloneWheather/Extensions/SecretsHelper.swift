//
//  Secrets.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 25.11.2024.
//
import Foundation


class SecretsHelper {
    enum Keys: String {
            case API_KEY = "WEATHER_API_KEY"
            case BASE_URL = "WEATHER_BASE_URL"
            case BASE_ONECALL_URL = "WEATHER_ONECALL_BASE_URL"
            case BASE_UV_URL = "WEATHER_UV_URL"
            case BASE_AIR_POLLUTION_URL = "WEATHER_AIR_POLUTION_URL"
        }
    
    static func value(forKey key: Keys) -> String? {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: String] else {
            print("Error: Secrets.plist not found or not in the correct format.")
            return nil
        }
        
        return dictionary[key.rawValue]
    }
}
