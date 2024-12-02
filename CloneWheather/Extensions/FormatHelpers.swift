//
//  FormatHelpers.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 29.11.2024.
//

import Foundation

extension Double {
    func formattedTemperature() -> String {
        if self == floor(self) {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.1f", self)
        }
    }
}
