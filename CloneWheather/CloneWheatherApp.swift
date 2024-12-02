//
//  CloneWheatherApp.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 17.11.2024.
//

import SwiftUI

@main
struct CloneWheatherApp: App {
    private let apiKey = SecretsHelper.Keys.API_KEY
    
    var body: some Scene {
        WindowGroup {
            WeatherView(apiKey: SecretsHelper.value(forKey: apiKey))
        }
    }
}
