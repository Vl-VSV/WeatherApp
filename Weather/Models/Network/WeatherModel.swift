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
}
