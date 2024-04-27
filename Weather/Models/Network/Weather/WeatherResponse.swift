//
//  WeatherResponse.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct WeatherResponse: Codable {
    let timeInterval: TimeInterval
    let name: String
    let main: Main
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case timeInterval = "dt"
        case name, main, weather
    }
}

// MARK: - Main

struct Main: Codable {
    let temp: Double
}

// MARK: - Weather

struct Weather: Codable {
    let description: String
    let icon: String
}
