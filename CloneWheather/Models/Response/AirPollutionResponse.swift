//
//  AirPollutionResponse.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation

struct AirPollutionResponse: Decodable {
    struct List: Decodable {
        struct Main: Decodable {
            let aqi: Int
        }
        let main: Main
    }
    let list: [List]
}
