//
//  ThemeHelper.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import Foundation
import SwiftUI

extension Color {
    struct Theme {
        let sectionHeaderColor : Color = Color(red: 0.54, green: 0.77, blue: 0.99)
    }
    
    static var currentTheme: Theme {
        return Theme()
    }
}
