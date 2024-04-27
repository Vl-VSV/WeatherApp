//
//  ForecastResponse.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [WeatherInfo]
    let city: City
}

// MARK: - Weather Info

struct WeatherInfo: Codable {
    let dt: TimeInterval
    let main: MainWeather
    let weather: [WeatherDetail]
}

// MARK: - Main Weather

struct MainWeather: Codable {
    let temp: Double
}

// MARK: - Weather Detail

struct WeatherDetail: Codable {
    let description: String
    let icon: String
}

// MARK: - City

struct City: Codable {
    let name: String
}
