//
//  LocationManager.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import CoreLocation

protocol ILocationManager {
    var delegate: ILocationManagerDelegate? { get set }
}

protocol ILocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocationCoordinate2D)
}

final class LocationManager: NSObject, ILocationManager {
    // MARK: - Properties

    private var locationManager = CLLocationManager()

    weak var delegate: ILocationManagerDelegate?

    // MARK: - Init

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            locationManager.stopUpdatingLocation()
            delegate?.didUpdateLocation(location)
        }
    }
}
