//
//  LocationManager.swift
//  MyApp
//
//  Created by Hien Nguyen on 5/31/18.
//  Copyright © 2018 Hien Nguyen. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func manager(manager: LocationManager, needsPerformAction action: LocationManager.Action)
}

final class LocationManager: NSObject {
    enum Action {
        case finishUpdatingLocation(location: CLLocation)
        case denied
    }
    static let shared = LocationManager()
    lazy var locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    var didGetLocation: ((Coordinate) -> Void)?
    private override init() {
        super.init()
        configLocationService()
    }

    func enableLocationServices() {
        CLLocationManager.locationServicesEnabled()
    }
    // Standard location service
    func startStandardLocationService() {
        locationManager.startUpdatingLocation()
    }

    func stopStandardLocationService() {
        locationManager.stopUpdatingLocation()
    }

    func configLocationService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .denied:
            delegate?.manager(manager: self, needsPerformAction: .denied)
        case .restricted:
            break
        }
    }
}
// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            stopStandardLocationService()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .notDetermined:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            print("Can not get GPS")
            return
        }
        let coordinate = Coordinate(location: location)
        if let didGetLocation = didGetLocation {
            didGetLocation(coordinate)
        }
        delegate?.manager(manager: self, needsPerformAction: .finishUpdatingLocation(location: location))
    }
}
private extension Coordinate {
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
