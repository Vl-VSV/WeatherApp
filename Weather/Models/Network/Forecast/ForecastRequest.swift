//
//  ForecastRequest.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct ForecastRequest: INetworkRequest {
    // MARK: - Properties

    let path: String = "/data/2.5/forecast/"
    let method: HTTPMethod = .get
    let parameters: Parameters

    // MARK: - Init

    init(latitude: Double, longitude: Double, apiKey: String = Constants.apiToken) {
        let queryParams: [String: Any] = [
            "lat": latitude,
            "lon": longitude,
            "units": "metric",
            "appid": apiKey
        ]
        self.parameters = .url(queryParams)
    }

    init(city: String, apiKey: String = Constants.apiToken) {
        let queryParams: [String: Any] = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        self.parameters = .url(queryParams)
    }
}