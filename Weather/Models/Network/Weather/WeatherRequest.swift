//
//  WeatherRequest.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import NetworkService

struct WeatherRequest: INetworkRequest {
    // MARK: - Parametrs

    let path: String = "/data/2.5/weather"
    let method: HTTPMethod = .get
    let parameters: Parameters

    // MARK: - Init

    init(latitude: Double, longitude: Double, lang: String = "en", apiKey: String = Constants.apiToken) {
        let queryParams: [String: Any] = [
            "lat": latitude,
            "lon": longitude,
            "units": "metric",
            "lang": lang,
            "appid": apiKey
        ]
        self.parameters = .url(queryParams)
    }

    init(city: String, lang: String = "en", apiKey: String = Constants.apiToken) {
        let queryParams: [String: Any] = [
            "q": city,
            "units": "metric",
            "lang": lang,
            "appid": apiKey
        ]
        self.parameters = .url(queryParams)
    }
}
