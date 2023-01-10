//
//  WeatherInteractor.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 07.01.2023.
//

import UIKit
import CoreLocation

protocol WeatherBisinessLogic {
    func requestData(request: WeatherEnum.Model.Request.RequestType)
}

class WeatherInteractor: NSObject, WeatherBisinessLogic, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    var presenter: WeatherPresentLogic?
    var networkManager = NetworkRequest()
    
    func requestData(request: WeatherEnum.Model.Request.RequestType) {
        switch request {
            
        case .getWeather:
            getLocation()
        }
    }
    
    private func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let coordinates = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
        
        guard let currentLocation = locationManager.location else { return }
        
        geoCoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.init(identifier: "ru_RU")) { placemarks, error in
            
            let locality = placemarks?[0].locality ?? (placemarks?[0].name ?? "Error")
            
            self.locationManager.startUpdatingLocation()
            
            self.networkManager.getWeather(coordinates: coordinates) { weatherResponse in
                guard let weatherResponse = weatherResponse else { return }
                self.presenter?.presentData(responce: .presentWeather(weather: weatherResponse, lacality: locality))
            }
        }
    }
}
