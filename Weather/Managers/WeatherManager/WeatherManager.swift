//
//  WeatherManager.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import CoreLocation
import NetworkService

protocol IWeatherManager {
    func getWeatherIn(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        lang: Languages
    ) async throws -> WeatherModel

    func getForecastIn(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        lang: Languages
    ) async throws -> [WeatherModel]

    func getWeatherIn(city: String, lang: Languages) async throws -> WeatherModel
    func getForecastIn(city: String, lang: Languages) async throws -> [WeatherModel]
}

final class WeatherManager: IWeatherManager {
    private let networkService: INetworkService

    // MARK: - Init

    init(networkService: INetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func getWeatherIn(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        lang: Languages
    ) async throws -> WeatherModel {
        let weatherRequest = WeatherRequest(latitude: latitude, longitude: longitude, lang: lang.rawValue)

        let weatherResponse: WeatherResponse = try await networkService.perform(weatherRequest)

        return createWeatherModel(from: weatherResponse)
    }

    func getWeatherIn(city: String, lang: Languages) async throws -> WeatherModel {
        let weatherRequest = WeatherRequest(city: city, lang: lang.rawValue)

        let weatherResponse: WeatherResponse = try await networkService.perform(weatherRequest)

        return createWeatherModel(from: weatherResponse)
    }

    func getForecastIn(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        lang: Languages
    ) async throws -> [WeatherModel] {
        let forecastRequest = ForecastRequest(latitude: latitude, longitude: longitude, lang: lang.rawValue)

        let forecastResponse: ForecastResponse = try await networkService.perform(forecastRequest)
        let cityName = forecastResponse.city.name

        return createWeatherModels(from: forecastResponse, cityName: cityName)
    }

    func getForecastIn(city: String, lang: Languages) async throws -> [WeatherModel] {
        let forecastRequest = ForecastRequest(city: city, lang: lang.rawValue)

        let forecastResponse: ForecastResponse = try await networkService.perform(forecastRequest)
        let cityName = forecastResponse.city.name

        return createWeatherModels(from: forecastResponse, cityName: cityName)
    }

    // MARK: - Private Methods

    private func createWeatherModel(from response: WeatherResponse) -> WeatherModel {
        return WeatherModel(
            iconID: response.weather[0].icon,
            tempurature: response.main.temp,
            cityName: response.name,
            description: response.weather[0].description,
            timeInterval: response.timeInterval
        )
    }

    private func createWeatherModels(from response: ForecastResponse, cityName: String) -> [WeatherModel] {
        return response.list.map {
            WeatherModel(
                iconID: $0.weather[0].icon,
                tempurature: $0.main.temp,
                cityName: cityName,
                description: $0.weather[0].description,
                timeInterval: $0.dt
            )
        }
    }
}
