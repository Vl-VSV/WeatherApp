//
//  WeatherModel.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct WeatherModel: Identifiable {
    // MARK: - Properties
    
    let id = UUID()
    let iconID: String
    let tempurature: Double
    let cityName: String
    let description: String
    let timeInterval: TimeInterval
    
    // MARK: - Computed Properties

    var tempuratureString: String {
        return String(format: "%.1f˚", tempurature)
    }

    var iconSF: String {
        switch iconID {
        case "01d", "01n":
            return "sun.max"
        case "02d", "02n":
            return "cloud.sun"
        case "03d", "03n":
            return "cloud"
        case "04d", "04n":
            return "smoke"
        case "09d", "09n":
            return "cloud.rain"
        case "10d", "10n":
            return "cloud.sun.rain"
        case "11d", "11n":
            return "cloud.bolt"
        case "13d", "13n":
            return "cloud.snow"
        case "50d", "50n":
            return "cloud.fog"
        default:
            return"multiply"
        }
    }

}
