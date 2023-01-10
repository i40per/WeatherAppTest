//
//  CurrentWeather.swift
//  WeatherAppTest
//
//  Created by Evgenii Lukin on 06.01.2023.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        String(format: "%.0f", temperature)
    }
    
    let dt: Int
    let timezone: Int
    
    let tempMin: Double
    let tempMax: Double
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        "\(feelsLikeTemperature.rounded())"
    }
    
    let icon: String
    let weatherDescription: String
    
    init?(currentWeatherData: CurrentWeatherData) {
        
        dt = currentWeatherData.dt
        timezone = currentWeatherData.timezone
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        icon = currentWeatherData.weather.first?.icon ?? "No data"
        weatherDescription = currentWeatherData.weather.first?.weatherDescription ?? "No data"
        tempMin = currentWeatherData.main.tempMin.rounded()
        tempMax = currentWeatherData.main.tempMax.rounded()
    }
}
