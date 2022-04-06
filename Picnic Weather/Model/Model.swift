//
//  Model.swift
//  Picnic Weather
//
//  Created by Christian Nachtrieb on 2/20/22.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    var forecast: [Day]
}

struct Day: Codable, Hashable {
    var name: String
    var temperature: Int
    var description: String
    var weatherIcon: String? {
        renderIcon(name: name, weatherDescription: description)
    }
}

private func renderIcon(name: String, weatherDescription: String) -> String? {
    
    let description = weatherDescription.lowercased()
    let name = name.lowercased()
    
    if name.contains("night") {
        switch description {
        case let str where str.contains("snow"): return "cloud.snow.fill"
        case let str where str.contains("rain"): return "cloud.moon.rain.fill"
        case let str where str.contains("storm"): return "cloud.moon.bolt.fill"
        case let str where str.contains("clear"): return "moon.stars.fill"
        default: return "cloud.moon.fill"
        }
        
    } else {
        switch description {
        case let str where str.contains("snow"): return "snowflake"
        case let str where str.contains("storm"): return "cloud.bolt.rain.fill"
        case let str where str.contains("rain") || str.contains("drizzle") || str.contains("shower"): return "cloud.rain.fill"
        case let str where str.contains("sun"): return "cloud.sun.fill"
        case let str where str.contains("cloud"): return "cloud.fill"
        default: return "cloud.fill"
        }
    }
}
