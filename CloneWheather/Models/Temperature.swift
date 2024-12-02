//
//  Temperature.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import Foundation


enum Temperature {
    static let degreeSynbol: String = "°"
    
    case F(_ value : Int)
    case C(_ value: Int)
    
    var valueInFFromC: Int {
        switch self {
        case .F(let value): return value
        case .C(let value): return Int(((Double(value) * 1.8) + 32.0).rounded())
        }
    }
    
    var valueInCFromF: Int {
        switch self {
        case .F(let value): return Int(((Double(value) - 32.0 ) * 0.5556).rounded())
        case .C(let value): return value
        }
    }
    
    var celciusString : String {
        return "\(valueInCFromF)\(Temperature.degreeSynbol)"
    }
    
    var fahrenheitString: String {
        return "\(valueInFFromC)\(Temperature.degreeSynbol)"
    }
}
