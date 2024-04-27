//
//  WeatherApp.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    // MARK: - Init
    
    init() {
        NetworkMonitor.shared.start()
    }

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
