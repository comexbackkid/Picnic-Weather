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
    var newIcon: String? {
        chooseIcon(name: name, weatherDescription: description)
    }
    var icon: WeatherIcon? {
        return WeatherIcon(rawValue: description)
    }
}

func chooseIcon(name: String, weatherDescription: String) -> String? {
    let description = weatherDescription.lowercased()
    
    if name.lowercased().contains("night") {
        return "cloud.moon.fill"
    } else if description.contains("showers") || description.contains("rain") {
        return "cloud.rain.fill"
    } else if name.lowercased().contains("night") && description.contains("rain") || description.contains("showers") {
        return "cloud.moon.rain"
    } else {
        return nil
    }
}

enum WeatherIcon: String, Codable {
    case sunny                      = "Sunny"
    case clear                      = "Clear"
    case mostlySunny                = "Mostly Sunny"
    case partlySunny                = "Partly Sunny"
    case partlyCloudy               = "Partly Cloudy"
    case rainLikely                 = "Rain Likely"
    case rainShowersLikely          = "Rain Showers Likely"
    case rain                       = "Rain"
    case chanceOfRain               = "Slight Chance Light Rain"
    case mostlyCloudy               = "Mostly Cloudy"
    case chanceRainSnow             = "Chance Rain And Snow"
    case chanceLightRain            = "Chance Light Rain"
    case lightRain                  = "Light Rain"
    case rainThenSnow               = "Light Rain Likely then Rain And Snow"
    case slightChanceRainSnow       = "Slight Chance Rain And Snow"
    case slightChanceRain           = "Slight Chance Rain Showers"
    case partlySunnyIsolatedShwrs   = "Partly Sunny then Isolated Rain Showers"
    case heavySnow                  = "Heavy Snow"
    case isolatedRainShowers        = "Isolated Rain Showers"

    
    var imageName: String {
        switch self {
        case .sunny, .clear:
            return "sun.max.fill"
        case .mostlySunny:
            return "cloud.sun.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .partlySunny:
            return "cloud.sun.fill"
        case .rainLikely:
            return "cloud.fill.fill"
        case .rain:
            return "cloud.rain.fill"
        case .chanceOfRain:
            return "cloud.sun.rain.fill"
        case .mostlyCloudy:
            return "cloud.fill"
        case .chanceRainSnow:
            return "cloud.snow.fill"
        case .lightRain:
            return "cloud.drizzle.fill"
        case .rainThenSnow:
            return "cloud.sleet.fill"
        case .slightChanceRainSnow:
            return "cloud.snow.fill"
        case .slightChanceRain:
            return "cloud.sun.rain.fill"
        case .rainShowersLikely:
            return "cloud.rain.fill"
        case .chanceLightRain:
            return "cloud.rain.fill"
        case .partlySunnyIsolatedShwrs:
            return "cloud.sun.rain.fill"
        case .heavySnow:
            return "snowflake"
        case .isolatedRainShowers:
            return "cloud.drizzle.fill"
        }
    }
    
    var image: Image {
        print("Setting image to: \(imageName)")
        return Image(systemName: imageName)
    }
}
