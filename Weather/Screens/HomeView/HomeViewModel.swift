//
//  HomeViewModel.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import CoreLocation
import NetworkService

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var weather: WeatherModel?
    @Published var forecast: [Date: [WeatherModel]]?
    @Published var isLoading: Bool = true
    
    // MARK: - Private Properties
    
    private let networkService: INetworkService
    private let weatherManager: IWeatherManager
    private var locationManager: ILocationManager
    
    // MARK: - Init
    
    init() {
        guard let baseURL = URL(string: Constants.baseUrlString) else {
            fatalError("Base URL is invalid")
        }
        
        let requestBuilder = RequestBuilder(baseUrl: baseURL)
        let session = URLSession.shared
        let networkMonitor = NetworkMonitor.shared
        
        self.networkService = NetworkService(
            session: session,
            networkMonitor: networkMonitor,
            requestBuilder: requestBuilder
        )
        
        self.weatherManager = WeatherManager(networkService: networkService)
        
        self.locationManager = LocationManager()
        
        locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    
    func showWeatherIn(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        isLoading = true
        
        do {
            async let weather = weatherManager.getWeatherIn(
                latitude: latitude,
                longitude: longitude,
                lang: LocalizationManager.preferredLanguage()
            )
            async let forecast = weatherManager.getForecastIn(
                latitude: latitude,
                longitude: longitude,
                lang: LocalizationManager.preferredLanguage()
            )
            
            self.weather = try await weather
            self.forecast = try await convertForecastToDictionary(forecast: forecast)
            
            isLoading = false
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func showWeatherIn(city: String) async {
        isLoading = true
        
        do {
            async let weather = weatherManager.getWeatherIn(
                city: city.trimmingCharacters(in: .whitespacesAndNewlines),
                lang: LocalizationManager.preferredLanguage()
            )
            async let forecast = weatherManager.getForecastIn(
                city: city.trimmingCharacters(in: .whitespacesAndNewlines),
                lang: LocalizationManager.preferredLanguage()
            )
            
            self.weather = try await weather
            self.forecast = try await convertForecastToDictionary(forecast: forecast)
            
            isLoading = false
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    // MARK: - Private Methods
    func convertForecastToDictionary(forecast: [WeatherModel]) -> [Date: [WeatherModel]] {
        var forecastDictionary: [Date: [WeatherModel]] = [:]
        let calendar = Calendar.current

        for weatherModel in forecast {
            let date = Date(timeIntervalSince1970: weatherModel.timeInterval)
            let components = calendar.dateComponents([.year, .month, .day], from: date)

            if let dateWithoutTime = calendar.date(from: components) {
                if var weatherModels = forecastDictionary[dateWithoutTime] {
                    weatherModels.append(weatherModel)
                    forecastDictionary[dateWithoutTime] = weatherModels
                } else {
                    forecastDictionary[dateWithoutTime] = [weatherModel]
                }
            }
        }

        return forecastDictionary
    }
}

extension HomeViewModel: ILocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        Task {
            await showWeatherIn(latitude: location.latitude, longitude: location.longitude)
        }
    }
}
