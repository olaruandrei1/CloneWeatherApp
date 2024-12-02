//
//  UVIndexResponse.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation

struct UVIndexResponse: Codable {
    let lat: Double
    let lon: Double
    let date_iso: String
    let value: Double
}
